/**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2018 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */

// INFORMATION FOR DEVELOPMENT MODE
const directory = __dirname.replace(/\\/g, ' ').match(/(\S+) themes/g)[0].replace(' themes', '');
const themeFolderName = __dirname.replace(/\\/g, ' ').match(/themes (\S+)/g)[0].replace('themes ', '');
// INFORMATION FOR DEVELOPMENT MODE

const ip = require('ip');
const webpack = require('webpack');
const argv = require('yargs').argv;
const finder = require('fs-finder');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const {resolve} = require("path");
const {sync: delSync} = require("del");
const replace = require('replace-in-file');
const request = require('request');
const {BundleAnalyzerPlugin} = require("webpack-bundle-analyzer");
const BrowserSyncPlugin = require('browser-sync-webpack-plugin');
const BrowserSyncHotPlugin = require("browser-sync-dev-hot-webpack-plugin");
const copy = require('copy-files');
const child = finder.from(__dirname + '/../../').findFiles('themeChildInfo.yml');

replace({allowEmptyPaths: true, files: [resolve(__dirname, 'js/*.js'), resolve(__dirname, './modules/**/*.js'), resolve(__dirname, './templates/**/*.js')], from: 'module.hot ? module.hot.accept() : false;', to: ''});
delSync([
  resolve(__dirname, `../assets/**/*.map`)
], {force: true});

if (argv.mode === 'development' && !argv.library) {
  replace({files: Object.keys(getModulesEntries(true, true)), from: [/[\s\S*]+/g, ''], to: ['', '/*browserSync development override*/']});
  setTimeout(function() {
    refreshData();
  }, 60000);
}

let bodyPrev = 0;
let bsSync = false;

let config = {
  devtool: argv.map === 'true' ? 'source-map' : 'eval',
  entry: getModulesEntries(argv.mode === 'production' || argv.library, false),
  output: {
    path: argv.mode === 'production' || argv.library ? __dirname : resolve(__dirname, '../assets/'),
    filename: argv.mode === 'production' || argv.library ? '[name].js' : 'js/[name].js',
    publicPath: argv.mode === 'production' || argv.library ? '' : 'http://localhost:3000/' + directory + '/themes/' + themeFolderName + '/assets/'
  },
  optimization: {
    minimizer: argv.mode === 'production' ? [
      new UglifyJsPlugin({
        cache: false,
        parallel: false,
        sourceMap: false
      }),
      new OptimizeCSSAssetsPlugin({})
    ] : []
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['es2015']
          }
        }
      },
      {
        test: /\.scss$/,
        use: [
          argv.mode === 'production' || argv.library ? 'style-loader' : 'css-hot-loader',
          MiniCssExtractPlugin.loader,
          {
            loader: 'css-loader',
            options: {
              sourceMap: argv.map === 'true',
              minimize: argv.mode === 'production'
            }
          },
          {
            loader: 'postcss-loader',
            options: {
              sourceMap: argv.map === 'true'
            }
          },
          {
            loader: 'sass-loader',
            options: {
              data: '@import "css/partials/_variables";',
              sourceMap: argv.map === 'true'
            }
          },
        ]
      },
      {
        test: /.(png|jpg|gif|woff(2)?|eot|ttf|svg)(\?[a-z0-9=\.]+)?$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name(file) {
                if (file.indexOf('node_modules') >= 0) {
                  return '../assets/css/[name].[ext]'
                } else if (file.indexOf('modules') >= 0) {
                  return '../[path][name].[ext]'
                } else {
                  return '../assets/[path][name].[ext]'
                }
              },
              publicPath(file) {
                if (file.indexOf('node_modules') >= 0) {
                  return '../css/' + file;
                } else if (file.indexOf('modules') >= 0) {
                  return '../../../' + file;
                } else {
                  return argv.mode === 'production' || argv.library ? '../' + file : file.replace('../', 'http://localhost:3000/' + directory + '/themes/' + themeFolderName + '/');
                }
              }
            }
          }
        ]
      }
    ]
  },
  externals: {
    prestashop: 'prestashop',
    $: '$',
    jquery: 'jQuery'
  },
  plugins: [
    new webpack.ProvidePlugin({
      Popper: ['popper.js', 'default'],
      ResizeSensor: ['theia-sticky-sidebar/dist/ResizeSensor.min.js']
    }),
    new MiniCssExtractPlugin({
      filename: argv.mode === 'production' || argv.library ? '[name]' : 'css/[name].css'
    }),
  ]
};

function getModulesEntries(prod, isHide) {
  const skipFiles = finder.in(__dirname).findFiles('*.*');
  const files = finder.from(__dirname).exclude(skipFiles).exclude(['node_modules', 'templates', 'partials', 'components', 'lib', 'img', 'fonts', 'index']).findFiles('*.*');
  const filesFromLibrary = finder.from(__dirname + '/templates/').exclude(['img', 'index']).findFiles('*.*');
  const entry = prod ? {} : {'theme': ['webpack/hot/dev-server', 'webpack-hot-middleware/client'],};
  const replaceJs = isHide ? '.js' : '';

  for (let i = 0; i < files.length; i++) {
    let name = files[i].indexOf('modules') !== -1 ? files[i].replace(__dirname, '..').replace('scss', 'css').replace('.js', replaceJs) : files[i].replace(__dirname, '../assets').replace('scss', 'css').replace('.js', replaceJs);
    prod ? entry[name] = files[i] : entry['theme'].push(files[i]);
  }
  if (argv.mode === 'production' || argv.library) {
    for (let i = 0; i < filesFromLibrary.length; i++) {
      let libFileName = filesFromLibrary[i].replace(__dirname, '..').replace('scss', 'css').replace('.js', replaceJs);
      entry[libFileName] = filesFromLibrary[i];
    }
  }

  return entry;
}

function refreshData() {

  request('http://' + ip.address() + '/' + directory + '/', function (error, response, body) {
    let bodyStr = (body + '').replace(/[^a-z]/g, '');
    if (bodyStr !== bodyPrev && bodyPrev !== 0) {
      bsSync.reload();
    }
    bodyPrev = bodyStr;
  });

  setTimeout(refreshData, 5000);
}

if (argv.mode === 'production' || argv.library) {
  config.plugins.push(
    {
      apply(compiler) {
        compiler.plugin("done", stats => {
          delSync([
            resolve(__dirname, `../**/*.css.js`)
          ], {force: true});
        });
      }
    },
  );
}

if (argv.library) {
  config.plugins.push(
    new BrowserSyncPlugin({
      reloadDelay: 300,
      files: [
        /* pwd() + */"../templates/**/*.*",
        /* pwd() + */"../assets/**/*.*",
        /* pwd() + */'../modules/**/*.*',
        {
          match: ["../templates/library/**/*.*"],
          fn:    function (event, file) {
            if (child[0] && event !== 'unlink' && event !== 'unlinkDir' && file.indexOf('.map') === -1 && file.indexOf('css.js') === -1) {
              let newFile = file.replace(/\\/g, ' ').match(/(\S+\.\S+)/g);
              let getDirFile = file.replace(/\\/g, ' ').replace(/.. templates library (\S+) (\S+) /, '').replace(newFile, '').replace(/ /g, '\\');
              let newDir = child[0].replace(/config(\S+)/, '') + getDirFile;
              copy({
                files: {
                  [newFile]: __dirname + '\\' + file
                },
                dest: newDir,
                overwrite: true
              }, function (err) {
                // All copied!
              });
            }
          }
        }
      ],
      proxy: {
        target: 'http://' + ip.address() + '/' + directory + '/',
        proxyRes: [
          function (proxyRes, req, res) {
            if (proxyRes.headers['content-type'] === 'application/json') {
              const _writeHead = res.writeHead;
              let _writeHeadArgs;
              const _end = res.end;
              let body = '';
              proxyRes.on('data', (data) => {
                data = data.toString('utf-8');
                body += data;
              });
              res.writeHead = (...writeHeadArgs) => {
                _writeHeadArgs = writeHeadArgs;
              };
              res.write = () => {};
              res.end = (...endArgs) => {
                const output = body.split(ip.address()).join('localhost:3000');
                if (proxyRes.headers && proxyRes.headers['content-length']) {
                  res.setHeader('content-length', output.length);
                }
                res.setHeader('transfer-encoding', '');
                res.setHeader('cache-control', 'no-cache');
                _writeHead.apply(res, _writeHeadArgs);
                if (body.length) {
                  _end.apply(res, [output]);
                } else {
                  _end.apply(res, endArgs);
                }
              }
            }
          }
        ]
      }
    }),
  );
}

if (argv.mode === 'development' && !argv.library) {
  config.plugins.push(
    new BrowserSyncHotPlugin({
      browserSync: {
        reloadDelay: 0,
        files: [
          /* pwd() + */"../templates/**/*.tpl",
          /* pwd() + */'../modules/**/*.tpl'
        ],
        proxy: {
          target: 'http://' + ip.address() + '/' + directory + '/',
          proxyRes: [
            function (proxyRes, req, res) {
              if (proxyRes.headers['content-type'] === 'application/json') {
                const _writeHead = res.writeHead;
                let _writeHeadArgs;
                const _end = res.end;
                let body = '';
                proxyRes.on('data', (data) => {
                  data = data.toString('utf-8');
                  body += data;
                });
                res.writeHead = (...writeHeadArgs) => {
                  _writeHeadArgs = writeHeadArgs;
                };
                res.write = () => {};
                res.end = (...endArgs) => {
                  const output = body.split(ip.address()).join('localhost:3000');
                  if (proxyRes.headers && proxyRes.headers['content-length']) {
                    res.setHeader('content-length', output.length);
                  }
                  res.setHeader('transfer-encoding', '');
                  res.setHeader('cache-control', 'no-cache');
                  _writeHead.apply(res, _writeHeadArgs);
                  if (body.length) {
                    _end.apply(res, [output]);
                  } else {
                    _end.apply(res, endArgs);
                  }
                }
              }
            }
          ]
        }
      },
      devMiddleware: {
        get publicPath() {
          return `http://localhost:3000/` + directory + `/themes/` + themeFolderName + `/assets/`;
        }
      },
      hotMiddleware: {},
      callback() {
        const {watcher: bs} = this;
        bsSync = bs;
        bsSync.emitter.on("file:changed", function () {
          bodyPrev = 0;
          bsSync.reload();
        });
        replace({allowEmptyPaths: true, files: [resolve(__dirname, 'js/*.js'), resolve(__dirname, './modules/**/*.js'), resolve(__dirname, './templates/**/*.js')], from: '', to: 'module.hot ? module.hot.accept() : false;'});
        delSync([
          resolve(__dirname, `theme.js`), resolve(__dirname, `../**/*.css.js`)
        ], {force: true});
      }
    }),
    new BundleAnalyzerPlugin({
      openAnalyzer: false
    }),
  );
}

module.exports = config;
