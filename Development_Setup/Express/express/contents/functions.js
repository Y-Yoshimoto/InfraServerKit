// Get
exports.get = function (req, res) {
    console.log(req.query.id)
    result = { "id": Number(req.query.id), "data": "testData", "other": "test" }
    console.log(result)
    res.json(result);
};
// Post
exports.post = function (req, res) {
    console.log(req.body);
    console.log(req.body.id);
    res.send('200 OK');
};

// Put
exports.put = function (req, res) {
    console.log(req.body);
    console.log(req.body.id);
    res.send('200 OK');
};

// delete
exports.delete = function (req, res) {
    console.log(req.body);
    console.log(req.body.id);
    res.send('200 OK');
};