package poly.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtil {
	public static String[] fileNewString(String param,MultipartHttpServletRequest file,String path,String userNo) {
		String fileServerName="";
		String fileOrgName=file.getFile(param).getOriginalFilename();
		String extended = fileOrgName.substring(fileOrgName.indexOf("."),fileOrgName.length());
		String now = new SimpleDateFormat("yyyyMMddhmsS").format(new Date()); //현재시간 나타내는 변수
		fileServerName=path+now+"-"+userNo+extended;//새로운 파일명으로 저장할 위치경로 + 시간 + 확장자 
		String fileOrgNameLoc=path+fileOrgName;
		String[] fileArray = {fileServerName,fileOrgNameLoc};
		return fileArray;
	}
	public static String audioToBuffer(String filePath) throws IOException {
		String fileString = new String();

	    FileInputStream inputStream =  null;
	    ByteArrayOutputStream byteOutStream = null;
		try {
			inputStream = new FileInputStream(filePath);
			byteOutStream = new ByteArrayOutputStream();
			int len = 0;
			byte[] buf = new byte[1024];
			while ((len = inputStream.read(buf)) != -1) {
				byteOutStream.write(buf, 0, len);
			}
			byte[] fileArray = byteOutStream.toByteArray();
			fileString = new String(Base64.encodeBase64(fileArray));
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			inputStream.close();
			byteOutStream.close();
		}
		return fileString;
	}
}