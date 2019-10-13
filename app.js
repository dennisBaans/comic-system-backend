// load all env variables from .env file into process.env object.
require('dotenv').config()
var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');

var mangaController = require('./controller/manga_controller'),
    genreController = require('./controller/genre_controller'),
    userAccountController = require('./controller/userAccount_controller'),
    chapterController = require('./controller/chapter_controller'),
    contentFolderStatusController = require('./controller/contentFolderStatus_controller'),
    userRoleController = require('./controller/userRole_controller'),
    categoryController = require('./controller/category_controller'),
    commentController = require('./controller/comment_controller'),
    counterController = require('./controller/counter_controller'),
    read_controller = require('./controller/read_controller'),
    blog_controller = require('./controller/blog_controller'),
    watchlist_controller = require('./controller/watchList_controller'),
    visableController = require('./controller/visable_controller');

const server = express();

server.use(bodyParser.json());


var corsOption = {
  origin: '*',
  optionSuccesStatus: 200
};
server.use(cors());

server.use('/api/covers/tmp', express.static('uploads'));
// API Controller
server.use('/api', mangaController.router);
server.use('/api', chapterController.router);
server.use('/api', genreController.router);
server.use('/api', visableController.router);
server.use('/api', contentFolderStatusController.router);
server.use('/api', userRoleController.router);
server.use('/api', userAccountController.router);
server.use('/api', categoryController.router);
server.use('/api', commentController.router);
server.use('/api', counterController.router);
server.use('/api', read_controller.router);
server.use('/api', blog_controller.router);
server.use('/api', watchlist_controller.router);
//server.use('/api', ratingController.router);

// error handlers
// Catch unauthorised errors
server.use(function (err, req, res, next) {
  if (err.name === 'UnauthorizedError') {
    res.status(401);
    res.json({"MyMessage" : err.name + ": " + err.message});
  }
});

let port = process.env.PORT;
if (port == null || port == "") {
  port = 8000;
}

server.listen(port, () => {
  console.log('Server started on Port ' + port);
});
