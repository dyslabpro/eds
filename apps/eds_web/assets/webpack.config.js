var webpack = require("webpack");
var merge = require("webpack-merge");
const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

var common = {
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: [/node_modules/, /semantic/, /uploads/],
        loader: "babel-loader"
      },
      {
        test: /\.hbs$/,
        loader: "handlebars-loader"
      },
      {
        test: [/\.scss$/, /\.css$/],
        use: [
          MiniCssExtractPlugin.loader,
          "css-loader",
          "postcss-loader"
        ]
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        exclude: /fonts/,
        loader: "file-loader?name=/images/[name].[ext]"
      },
      {
        test: /\.(ttf|eot|svg|woff2?)$/,
        exclude: /images/,
        loader: "file-loader?name=/fonts/[name].[ext]",
      }
    ]
  },
  optimization: {
    minimizer: [
    new UglifyJsPlugin({cache: true, parallel: true}),
      new OptimizeCSSAssetsPlugin({})
    ]
  }
};

module.exports = (env, options) => [
  merge(common, {
    entry: [
      __dirname + "/app/app.css",
      __dirname + "/app/app.js"
    ],
    output: {
      path: __dirname + "/../priv/static",
      filename: "js/app.js"
    },
    resolve: {
      modules: [
        "node_modules",
        __dirname + "/app"
      ]
    },
    plugins: [
      new webpack.ProvidePlugin({$: "jquery", jQuery: "jquery"}),
      new MiniCssExtractPlugin({filename: "css/app.css"})
    ]
  }),
  merge(common, {
    entry: [
      __dirname + "/admin/admin.css",
      __dirname + "/admin/admin.js"
    ],
    output: {
      path: __dirname + "/../priv/static",
      filename: "js/admin.js"
    },
    resolve: {
      modules: [
        "node_modules",
        __dirname + "/admin"
      ]
    },
    plugins: [
      new webpack.ProvidePlugin({$: "jquery", jQuery: "jquery"}),
      new MiniCssExtractPlugin({filename: "css/admin.css"})
    ]
  })
];