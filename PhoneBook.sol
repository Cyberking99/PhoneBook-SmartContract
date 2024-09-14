// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract PhoneBook {

    struct Contact {
        uint id;
        string name;
        string number;
    }

    uint count;
    mapping(address => Contact[]) public contact;

    function addContact(string memory _name, string memory _number) public {
        count++;
        Contact memory newContact = Contact(count, _name, _number);
        contact[msg.sender].push(newContact);
    }

    function getAllContacts() public view returns (Contact[] memory) {
        return contact[msg.sender];
    }

    function getContact(uint _id) public view returns (uint, string memory, string memory){
        require(_id < contact[msg.sender].length, "Error: Contact not found");
        Contact memory theContact = contact[msg.sender][_id];
        return (_id, theContact.name, theContact.number);
    }

    function updateContact(uint _id, string memory newName, string memory newPhone) public {
        require(_id < contact[msg.sender].length, "Error: Contact not found");
        Contact storage theContact = contact[msg.sender][_id];
        theContact.name = newName;
        theContact.number = newPhone;
    }

    function deleteContact(uint _index) public {
        require(_index < contact[msg.sender].length, "Error: Contact does not exist.");
        contact[msg.sender][_index] = contact[msg.sender][contact[msg.sender].length - 1];
        contact[msg.sender].pop();
    }

    function totalContacts() public view returns (uint) {
        return contact[msg.sender].length;
    }
}