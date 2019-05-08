package poly.persistance.mapper;



import config.Mapper;
import poly.dto.UserDTO;

@Mapper("UserMapper")
public interface UserMapper {

	//이메일이 있는지 확인
	public int checkLogin(UserDTO uDTO) throws Exception;
	//이메일이 없으면 db 저장
	public int insertUserRegSns(UserDTO uDTO) throws Exception;
	//이메일 있으면 유저번호 조회
	public String getFindUserNo(UserDTO uDTO) throws Exception;
	


	
}
