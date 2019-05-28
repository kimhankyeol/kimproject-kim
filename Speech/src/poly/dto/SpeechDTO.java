package poly.dto;

public class SpeechDTO {

	private String speechNo;
	private String spcJobTag;
	private String spcJobTitle;
	private String spcJobQuestion;
	private String regdate;
	private String regno;
	private String upddate;
	private String updno;
	private FileDTO file;
	private UserDTO user;
	

	public FileDTO getFile() {
		return file;
	}
	public void setFile(FileDTO file) {
		this.file = file;
	}
	public UserDTO getUser() {
		return user;
	}
	public void setUser(UserDTO user) {
		this.user = user;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getRegno() {
		return regno;
	}
	public void setRegno(String regno) {
		this.regno = regno;
	}
	public String getUpddate() {
		return upddate;
	}
	public void setUpddate(String upddate) {
		this.upddate = upddate;
	}
	public String getUpdno() {
		return updno;
	}
	public void setUpdno(String updno) {
		this.updno = updno;
	}

	public String getSpeechNo() {
		return speechNo;
	}
	public void setSpeechNo(String speechNo) {
		this.speechNo = speechNo;
	}
	public String getSpcJobTag() {
		return spcJobTag;
	}
	public void setSpcJobTag(String spcJobTag) {
		this.spcJobTag = spcJobTag;
	}
	public String getSpcJobTitle() {
		return spcJobTitle;
	}
	public void setSpcJobTitle(String spcJobTitle) {
		this.spcJobTitle = spcJobTitle;
	}
	public String getSpcJobQuestion() {
		return spcJobQuestion;
	}
	public void setSpcJobQuestion(String spcJobQuestion) {
		this.spcJobQuestion = spcJobQuestion;
	}
	
}
