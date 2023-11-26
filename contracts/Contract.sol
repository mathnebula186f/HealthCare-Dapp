// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract Contract{

    struct Patient{
        uint patientID;
        address patientAddress;
        string name;
        uint age;
        string gender;
        string bimari;
        uint requestID;
    }
    struct Doctor{
        uint doctorID;
        address doctorAddress;
        string name;
        uint requestID;
    }
    struct Request {
        uint requestID;
        address from;
        address to;
        string isAccess;
        string treatMent;
    }
    uint public doctorCount;
    uint public patientCount;
    uint public requestCount;
    mapping (address => Patient) public patients;
    mapping (address => Doctor) private doctors;
    mapping (uint => Request) private requests;
    mapping (uint =>Patient) public patientts;

    function registerPatient(string calldata _name,uint _age,string calldata _gender,string calldata _bimari) external {
        patientCount++;
        patients[msg.sender]=Patient({
            patientID:patientCount,
            patientAddress:msg.sender,
            name:_name,
            age:_age,
            gender:_gender,
            bimari:_bimari,
            requestID:0
        });
        patientts[patientCount]=Patient({
            patientID:patientCount,
            patientAddress:msg.sender,
            name:"",
            age:0,
            gender:"",
            bimari:"",
            requestID:0
        });
    }
    function checkAccount() external view returns (string memory) {
        if (patients[msg.sender].patientAddress != address(0)) {
            return "Patient";
        }
        else if (doctors[msg.sender].doctorAddress != address(0)) {
            return "Doctor";
        }
        else {
            return "No";
        }
    }
    function registerDoctor(string calldata _name) external {
       // require(clients[msg.sender].clientAddress == address(0), "Client already registered");
        doctorCount++;
        doctors[msg.sender] = Doctor({
            doctorID:doctorCount,
            doctorAddress: msg.sender,
            name: _name,
            requestID:0
        });
    }
    function checkRequestIDForDoctor() external view returns (uint) {
        require(doctors[msg.sender].doctorAddress != address(0), "Only dcotors can check requested services");
        return doctors[msg.sender].requestID;
    }
    function checkRequestedIDForPatient() external view returns (uint) {
        require(patients[msg.sender].patientAddress != address(0), "Only service providers can check requested services");
        return patients[msg.sender].requestID;
    }
    function getPatientInfo(uint _requestID) external view returns (Patient memory) {
        require(_requestID > 0 && _requestID <= requestCount, "Invalid request ID");
        address patientAddress = requests[_requestID].to;
        return patients[patientAddress];
    }
    function getRequestInfo(uint _requestID) external view returns (Request memory) {
        require(_requestID > 0 && _requestID <= requestCount, "Invalid request ID");
        // address patientAddress = requests[_requestID].to;
        return requests[_requestID];
    }

    function requestService(address _patientAddress) external {
        require(doctors[msg.sender].doctorAddress != address(0), "Only clients can request services");
        // Service memory service = services[_serviceID];
        // address serviceProviderAddress = service.serviceProviderAddress;
        // Increment requestCount
        requestCount++;

        // Create a new Request
        requests[requestCount] = Request({
            requestID: requestCount,
            from: msg.sender,
            to: _patientAddress,
            isAccess:"No",
            treatMent:""
        });

        // Update requested service in ServiceProvider
        patients[_patientAddress].requestID = requestCount;

        // Update requested service in Client
        doctors[msg.sender].requestID = requestCount;
    }
    function sendTreatMent(uint _requestID,string calldata _medicine) external {
        require(doctors[msg.sender].doctorAddress != address(0), "Only clients can request services");
        requests[_requestID].isAccess = "Full";
        requests[_requestID].treatMent = _medicine;
    }
    function giveAccess(uint _requestID) external {
        require(patients[msg.sender].patientAddress != address(0), "Only service providers can check requested services");
        requests[_requestID].isAccess = "Yes";
    }
    function declineRequest(uint _requestID) external {
        require(patients[msg.sender].patientAddress != address(0), "Only service providers can check requested services");
        requests[_requestID].isAccess = "No";
        address patientAddress1 = requests[_requestID].to;
        address doctorAddress1 = requests[_requestID].from;
        patients[patientAddress1].requestID = 0;
        doctors[doctorAddress1].requestID = 0;
    }
}