const gulp = require('gulp');
const sass = require('gulp-sass');
const minifyHTML = require('gulp-minify-html');
const browserify = require('browserify');
const babelify = require('babelify');
const source = require('vinyl-source-stream');
const browserSync = require('browser-sync');
const minifyjs = require('gulp-uglify');
const buffer = require('vinyl-buffer');

gulp.task('js', () => {
  browserify('ui/js/app.jsx')
  .transform(babelify, {presets: ["es2016", "react"]})
  .bundle()
  .pipe(source('bundle.js'))
  .pipe(buffer())
  .pipe(minifyjs())
  .pipe(gulp.dest('build'));
});

gulp.task('minify-html', () => {

  return gulp.src('ui/index.html')
    .pipe(minifyHTML())
    .pipe(gulp.dest('./build/'));
});

gulp.task('sass', () => {
  gulp.src('ui/styles/styles.scss')
  .pipe(sass({includePaths: ['scss']}))
  .pipe(gulp.dest('./build'));
});

gulp.task('browser-sync', () => {
  browserSync.init(["ui/**/*.*"], {
    server: {
      baseDir: "./build"
    }
  });
});

gulp.task('default', ['minify-html', 'sass', 'js'], () => {
  gulp.watch("ui/styles/*.scss", ['sass']);
  gulp.watch('ui/**/*.jsx', ['js']);
  gulp.watch('ui/*.html', ['minify-html']);
});
