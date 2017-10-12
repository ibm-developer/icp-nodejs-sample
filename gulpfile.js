var gulp = require('gulp');

var nodemon = require('gulp-nodemon');

var notify = require('gulp-notify');

var livereload = require('gulp-livereload');

/* Reload the application (npm start will call server/server.js 
  when there are change in any of the files we care about  (under "ext")
  the livereload plugin is useful and available as a browser extension. 
  When changes are made your application can automatically redeploy and refresh */

gulp.task('default', function() {
  livereload.listen();
  nodemon({
    script: 'server/server.js',
    ext: "js html css ejs"
  }).on('restart', function(){
    gulp.src('server/server.js')
    .pipe(livereload())
  })
})
