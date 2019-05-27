package poly.dto;

public class AuthorDTO {
	private String regdate;
	private String regno;
	private String upddate;
	private String updno;
	private SpeechDTO sDTO;
	private FileDTO fDTO;
	
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
	public SpeechDTO getsDTO() {
		return sDTO;
	}
	public void setsDTO(SpeechDTO sDTO) {
		this.sDTO = sDTO;
	}
	public FileDTO getfDTO() {
		return fDTO;
	}
	public void setfDTO(FileDTO fDTO) {
		this.fDTO = fDTO;
	}
	
	
}
