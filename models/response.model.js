exports.responseList = (code, msg) => {
    const responseList  = [];
    responseList[0]     = { codeResponse: code, replayMsg: msg};
    return responseList;
};