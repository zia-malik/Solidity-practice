// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

    contract Quiz {

    struct Answer
    {
        bytes32 text; 
        uint voteCount; // number of accumulated votes
        // add more non-key fields as needed
    }

    struct Question
    {
        bytes32 text;
        bytes32[] answerList; // list of answer keys so we can look them up
        mapping(bytes32 => Answer) answerStructs; // random access by question key and answer key
        // add more non-key fields as needed
    }

    mapping(bytes32 => Question) questionStructs; // random access by question key
    bytes32[] questionList; // list of question keys so we can enumerate them

    function newQuestion(bytes32 questionKey, bytes32 text) public
        // onlyOwner
        returns(bool success)
    {
        // not checking for duplicates
        questionStructs[questionKey].text = text;
        questionList.push(questionKey);
        return true;
    }

    function getQuestion(bytes32 questionKey)
        public
        view
        returns(bytes32 wording, uint answerCount)
    {
        return(questionStructs[questionKey].text, questionStructs[questionKey].answerList.length);
    }

    function addAnswer(bytes32 questionKey, bytes32 answerKey, bytes32 answerText) public
        // onlyOwner
        returns(bool success)
    {
        questionStructs[questionKey].answerList.push(answerKey);
        questionStructs[questionKey].answerStructs[answerKey].text = answerText;
        // answer vote will init to 0 without our help
        return true;
    }

    function getQuestionAnswer(bytes32 questionKey, bytes32 answerKey)
        public
        view
        returns(bytes32 answerText, uint answerVoteCount)
    {
        return(
            questionStructs[questionKey].answerStructs[answerKey].text,
            questionStructs[questionKey].answerStructs[answerKey].voteCount);
    }

    function getQuestionCount()
        public
        view
        returns(uint questionCount)
    {
        return questionList.length;
    }

    function getQuestionAtIndex(uint row)
        public
        view
        returns(bytes32 questionkey)
    {
        return questionList[row];
    }

    function getQuestionAnswerCount(bytes32 questionKey)
        public
        view
        returns(uint answerCount)
    {
        return(questionStructs[questionKey].answerList.length);
    }

    function getQuestionAnswerAtIndex(bytes32 questionKey, uint answerRow)
        public
        view
        returns(bytes32 answerKey)
    {
        return(questionStructs[questionKey].answerList[answerRow]);
    }  
}