public class Information {

    public IPhone iphone;

    public String operationSystem = "IOS";         // 운영체제 이름
    public String dataSort = "LET";                // 데이터 종류
    public String communicationFirm = "LG U+";       // 통신회사
    public int communicationCapacity = 3;      // 전화가 터지는 정도
    public final int COMMUNICATION_CAPACITY_NUM = 4; //통신량 최대 5칸

    public Information(IPhone iphone) {
        this.iphone = iphone;
    }
  
    public void change_communicationFirm(String name) {  // 환경설정에서 통신사를 바꿀 때 사용
        communicationFirm = name;
    }
  
    public void change_dataSort(String name) {  // 환경설정에서 데이터 유형을 바꿀 때 사용
        dataSort = name;
    }
    
    public void set_operationSystem(String system){
        operationSystem = system;
        iphone.display.informationBar.operationSystem = operationSystem;
    }
    
    public void set_dataSort(String dataSort){
        this.dataSort = dataSort;
        iphone.display.informationBar.dataSort = dataSort;
    }
    
    public void set_communicationFirm(String firm){
        communicationFirm = firm;
        iphone.display.informationBar.communicationFirm = communicationFirm;
    }
    
    public void set_communicationCapacity(int capacity){
        if(communicationCapacity<0)
            communicationCapacity = 0;
        else
            communicationCapacity = capacity;
        iphone.display.informationBar.communicationCapacity = communicationCapacity;
    }
}
