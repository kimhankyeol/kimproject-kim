package poly.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtil {
	public static String[] fileNewString(String param,MultipartHttpServletRequest file,String path) {
		String fileServerName="";
		String fileOrgName=file.getFile(param).getOriginalFilename();
		String extended = fileOrgName.substring(fileOrgName.indexOf("."),fileOrgName.length());
		String now = new SimpleDateFormat("yyyyMMddhmsS").format(new Date()); //현재시간 나타내는 변수
		fileServerName=path+now+extended;//새로운 파일명으로 저장할 위치경로 + 시간 + 확장자 
		String fileOrgNameLoc=path+fileOrgName;
		String[] fileArray = {fileServerName,fileOrgNameLoc};
		return fileArray;
	}
}