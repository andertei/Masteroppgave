function pictureSeqenceAndVideo(pictureMatrix,filename,fps)
	dummy=imread('bilde.png');
	[n,m,frames] = size(pictureMatrix);
	for i=1:frames
		picture = squeeze(pictureMatrix(:,:,i));
		picture = picture/max(max(max(pictureMatrix)));
		imwrite(picture,strcat(strcat(filename,num2str(i)),'.png'));
	end;
    
    
    
    writerObj = VideoWriter(strcat(strcat(filename,num2str(fps)),'fps_MOVIE.avi'),'Uncompressed AVI');
    writerObj.FrameRate = fps;
    open(writerObj);
    
    for k = 100:frames %discards first 100 frames (set by pre-trigger value)
        img = squeeze(pictureMatrix(:,:,k));
        img = img/max(max(max(pictureMatrix)));
        writeVideo(writerObj,img);
    end

close(writerObj);
    
end
