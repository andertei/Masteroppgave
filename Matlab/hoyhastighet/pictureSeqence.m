function pictureSeqence(pictureMatrix,filename);
	dummy=imread("bilde.png");
	[n,m,frames] = size(pictureMatrix);
	for i=1:frames
		picture = squeeze(pictureMatrix(:,:,i));
		picture=picture/max(max(max(pictureMatrix)));
		imwrite(picture,strcat(strcat(filename,num2str(i)),".png"));
	end;
end;
