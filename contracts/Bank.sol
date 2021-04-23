// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract LoanDisbursement {
    struct Applicant {
        string name;
        uint credScore;
        uint credAge;
        bool approved;
    }

    address public loanOfficer;
    mapping (address => Applicant) public applicants;

    // event to let others know when an applicant has been approved for a loan
    event Approved(string name, uint credScore);
    event Declined(string name, uint credScore);

    constructor() {
        loanOfficer = msg.sender;
    }

    function addApplicant(address newApp, string memory name, uint credRating, uint ageOfCredit) external {
        require(msg.sender == loanOfficer, "Only the loan officer can add an applicant to the pool.");
        require(applicants[newApp].credScore == 0, "This user already has an application in the pool.");
        applicants[newApp] = Applicant(name, credRating, ageOfCredit, false);
    }

    function viewApplicant(address applicantAddress) external view returns (
        string memory name,
        uint credScore,
        uint credAge,
        bool approved
    ) {
        return (
            applicants[applicantAddress].name,
            applicants[applicantAddress].credScore,
            applicants[applicantAddress].credAge,
            applicants[applicantAddress].approved
            );
    }

    function makeDecision(address person) external {
        require(msg.sender == loanOfficer, "Only the loan officer can initiate a decision.");
        require(bytes(applicants[person].name).length != 0, "That person is not in the pool of applicants.");
        if (applicants[person].credScore > 650 && applicants[person].credAge > 5) {
            applicants[person].approved = true;
            // broadcast the event to listeners
            emit Approved(applicants[person].name, applicants[person].credScore);
        } else {
            emit Declined(applicants[person].name, applicants[person].credScore);
        }
    }
}