function [frame_output, info]= xviread_smh(filename,frames)
% The XVI file format (2.1)
% 
% The first 1024 bytes of an .XVI file is reserved for header information, 
% which currently contains the following data structure:
% 
% typedef struct
% {
%     //////////////////////////////////////////////////////////////////////////////////////////
%     // 1.1 Area
%     unsigned long majorversion; 	// 2
%     unsigned long minorversion;	// 1
%     unsigned long framesize; 		// (frame size w*h*bpp*chans) + footer size
%     unsigned long bitsize;		// 12   (bits per channel)
%     unsigned long width;			// 320
%     unsigned long height;			// 256
%     unsigned long framerate;		// fps  (recording rate)
%     unsigned long startoffset;        // start of frames (aka, zip stream size = startoffset-1024 bytes)
%     unsigned long streamsize;         // zip archive size, the rest is padding
%     unsigned long realframesize;      // size of frame without footer
% 
%     unsigned char pixelformat;        // 0 = mono
%     unsigned char channels;           // will be 1 for mono
%     unsigned char bytesperchannel;    // will be 2 for 16 bit mono
%     unsigned char alignment;          // 0 = right, 1 = left
% 
%     unsigned long camera_id;          // vendorid + productid
%     unsigned long camera_serial;      // serial number
% 
% } XVIHDRv21;

% The XVI file format (2.1) Per frame footers
% 
% #pragma pack(push, 1)
% 
% /** Per frame footer */
% typedef struct  
% {
%     unsigned short len; /**< Structure length                               */
%     unsigned short ver; /**< AA00                                           */
% 
%     long long      soc; /**< Time of Start Capture (us since start of epoch)*/
%     long long      tft; /**< Time of reception (us since start of epoch)    */
%     dword          tfc; /**< Framecounter                                   */
%     dword          hfl; /**< Hardware footer length                         */
%                         /* Followed by a hardware framefooter, if available */
% } XPFF;
% 
% #pragma pack(pop)



fid=fopen(filename);


major_version=fread(fid,1,'long');
minor_version=fread(fid,1,'long');
framesize=fread(fid,1,'long');

bitsize=fread(fid,1,'long');
width=fread(fid,1,'long');
height=fread(fid,1,'long');
framerate=fread(fid,1,'long');
startoffset=fread(fid,1,'long');
streamsize=fread(fid,1,'long');
realframesize=fread(fid,1,'long');

pixelformat=fread(fid,1,'char');
channels=fread(fid,1,'char');
bytesperchannel=fread(fid,1,'char');
alignment=fread(fid,1,'char');

camera_id=fread(fid,1,'long');
camera_serial=fread(fid,1,'long');

status = fseek(fid, startoffset, 'bof');
%pos_of_first_frame
%frame=fread(fid,[height,width],'ushort')
ind=0;
frame_t=[];
lastframe=0;
while not(feof(fid))&&not(lastframe)&&(ind<max(frames))
 status = fseek(fid, startoffset+framesize*ind, 'bof');
 if not(feof(fid))
     ind=ind+1
     frame=fread(fid,[width,height],'ushort');
     frame_t(:,:,ind)=transpose(frame);
     len(:,ind)=fread(fid,1,'ushort');
     ver(:,ind)=fread(fid,1,'ushort');
     soc(:,ind)=fread(fid,1,'ulong');
     tft(:,ind)=fread(fid,1,'long');
     tft1(:,ind)=fread(fid,1,'long');
     tft2(:,ind)=fread(fid,1,'long');
     
     tfc(:,ind)=fread(fid,1,'int32');%framecounter
     currentposition=ftell(fid);
     hfl(:,ind)=fread(fid,1);      
%     hfl(:,ind)=fread(fid,1,'int32');    
% unsigned short trig_ext:1;          ///< External trigger state
trig_ext(:,ind)=fread(fid,1,'ushort');
%                 unsigned short trig_cl:1;           ///< Camera link trigger pin state
trig_cl(:,ind)=fread(fid,1,'ushort');
%                 unsigned short trig_soft:1;         ///< Software trigger state
trig_soft(:,ind)=fread(fid,1,'ushort');
%                 unsigned short reserved:10;         ///< RFU
RFU(:,ind)=fread(fid,1,'ushort');
%                 unsigned short filterwheel:3;       ///< Current filter
filterwheel(:,ind)=fread(fid,1,'ushort');
%                 wheel position
%         unsigned int   tint;                        ///< Active exposure time in truncated us.
tint(:,ind)=fread(fid,1,'uint8');
%         unsigned int   timelo;                      ///< Timestamp lo
timelo(:,ind)=fread(fid,1,'uint8');
%         unsigned int   timehi;                      ///< Timestamp hi (64-bit since the start of the unix epoch)
timehi(:,ind)=fread(fid,1,'uint8');
%         unsigned short temp_die;                    ///< Die temperature in degrees Kelvin
temp_die(:,ind)=fread(fid,1,'uint8');
%         unsigned short temp_case;                   ///< Case temperature in degrees Kelvin


test1(:,ind)=fread(fid,1,'ushort');    
test2(:,ind)=fread(fid,1,'ushort');    
test3(:,ind)=fread(fid,1,'ushort');    
test4(:,ind)=fread(fid,1,'ushort');    
test5(:,ind)=fread(fid,1,'ushort');    
test6(:,ind)=fread(fid,1,'ushort');    
     field=fread(fid,1,'ushort');    
%     tint=fread(fid,1,'int');    
     hfl_vector=fread(fid,hfl(:,ind)*1);
 end
 
status = fseek(fid, startoffset+framesize*(ind+1), 'bof');
lastframe=status;

end
numberofframe=ind;
frame_output=frame_t;
info.width=width;
info.height=height;
info.numberofframes=numberofframe;
% for ind=1:numberofframe
%     imagesc(frame_t(:,:,ind))
%     M(ind)=getframe(gcf)
% end

% #ifndef _X_FOOTERS_H_
% #   define _X_FOOTERS_H_
% 
%     /** Per frame Structures */
% 
% #pragma pack(push, 1)
% 
%     /// Hardware footer structure for ONCA class cameras (class pid = 0xf040)
%     typedef struct
%     {
%         union
%         {
%             struct
%             {
%                 // 1111 1100 0000 0000
%                 // 5432 1098 7654 3210
%                 unsigned short trig_ext:1;          ///< External trigger state
%                 unsigned short trig_cl:1;           ///< Camera link trigger pin state
%                 unsigned short trig_soft:1;         ///< Software trigger state
%                 unsigned short reserved:10;         ///< RFU
%                 unsigned short filterwheel:3;       ///< Current filter wheel position
%             } statusbits;                           ///< ...
%             unsigned short field;                   ///< ...
%         } status;                                   ///< ...
%         unsigned int   tint;                        ///< Active exposure time in truncated us.
%         unsigned int   timelo;                      ///< Timestamp lo
%         unsigned int   timehi;                      ///< Timestamp hi (64-bit since the start of the unix epoch)
%         unsigned short temp_die;                    ///< Die temperature in degrees Kelvin
%         unsigned short temp_case;                   ///< Case temperature in degrees Kelvin
%     } XPFF_F040;
% 
%     typedef struct
%     {
%         union
%         {
%             struct
%             {
%                 unsigned short trig_ext  :1;       ///<External trigger state
%                 unsigned short reserved  :15;
%             } statusbits;
%             unsigned short field;
%         } status;
%         unsigned int    tint;                      ///<Integration time in microseconds
%         unsigned int    timelo;                    ///<Timestamp low
%         unsigned int    timehi;                    ///<Timestamp hi (64-bit since the start of the unix epoch)
%         unsigned short  temp_die;                  ///<Sensor temperature (Die temp) in centi-Kelvin
%         unsigned short  reserved1;
%         unsigned short  tag;
%         unsigned int    image_offset;              ///<Global offset applied to all pixels in the frame (signed 32 bit number)
%         unsigned short  image_gain;                ///<Global gain applied to the pixels in the frame (8.8 fixed point number)
%         unsigned int    reserved2;
%     } XPFF_F003;
% 
%     /** Per frame footer */
%     typedef struct  
%     {
%         unsigned short len;     /**< Structure length                                                   */
%         unsigned short ver;     /**< AA00                                                               */
% 
%         long long      soc;     /**< Time of Start Capture                                              */
%         long long      tft;     /**< Time of reception                                                  */
%         dword          tfc;     /**< Framecounter                                                       */
%         dword          fltref;  /**< Filter marker, top nibble specifies purpose                        */
%                                 /**< 0x1xxxxxxx - Filter generated trigger event (x=filter specific)    */
%                                 /**< 0x2xxxxxxx - Start/End of sub-sequence marker (x=0 / x=1)          */
%         dword          hfl;     /**< Hardware footer length                                             */
%                                 /*   Followed by a hardware framefooter, if available                   */
% 
%         struct
%         {
%             unsigned short pid;              ///< Footer class identifier
%             union
%             {
%                 XPFF_F040      onca;         ///< pid == 0xF040
%                 XPFF_F003      gobi;         ///< pid == 0xF020, 0xF021, 0xF031
%             } Cameras;                       ///< ...
%         } Common;                            ///< ...
% 
%     } XPFF_GENERIC;
% 
% #pragma pack(pop)
% 
% #endif
