package poly.dto;

public class SpeechDTO extends AuthorDTO{

	private String speechNo;
	private String spcJobTag;
	private String spcJobTitle;
	private String spcJobQuestion;
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
