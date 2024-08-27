// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;


contract TodoList {
    uint256 public _idUser;
    address public ownerOfContact;

    address[] public creators;
    string[] public message;
    uint256[] public messageId;

    struct TodoListApp {
        address account;
        uint256 userId;
        string message;
        bool completed;
    }

    event TodoEvent(
        address indexed account,
        uint256 indexed userId,
        string message,
        bool completed
    );

    mapping (address => TodoListApp) public todoListApps;

    constructor(){
        ownerOfContact = msg.sender;
    }

    function inc() internal{
        _idUser++;
    }

    function createList(string calldata _message) external{
        inc();

        uint256 idNumber = _idUser;
        TodoListApp storage todo = todoListApps[msg.sender];

        todo.account = msg.sender;
        todo.message = _message;
        todo.completed = false;
        todo.userId = idNumber;

        creators.push(msg.sender);
        message.push(_message);
        messageId.push(idNumber);

        emit TodoEvent(msg.sender, todo.userId, _message, todo.completed);
    }

    function getCreatorData(address _address) public view returns(address, uint256, string memory, bool){
        TodoListApp memory singleUserData = todoListApps[_address];
        return (
            singleUserData.account,
            singleUserData.userId,
            singleUserData.message,
            singleUserData.completed
        );
    }

    function getAddress() external view returns (address[] memory) {
        return creators;
    }

    function getMessage() external view returns (string[] memory) {
        return message;
    }

    function toggle(address _creator) public {
        TodoListApp storage singleUserData = todoListApps[_creator];
        singleUserData.completed = !singleUserData.completed;
    }

}