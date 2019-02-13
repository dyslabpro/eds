exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      // joinTo: "js/app.js"

      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      joinTo: {
        "js/app.js": [
          "js/app.js",
          "js/socket.js",
          "vendor/js/jquery.min.js",
          "vendor/js/bootstrap.min.js"
        ],
        "js/admin.js": [
            "js/app.js",
            "vendor/js/jquery.min.js",
            "vendor/js/jquery-ui.min.js",
            "vendor/js/bootstrap.min.js",
            "vendor/js/adminlte.min.js"
        ],
      },
      order: {
        before: [
          "vendor/js/jquery.min.js",
          "vendor/js/bootstrap.min.js"
        ]
      }
    },
    stylesheets: {
      joinTo: {
        "css/app.css": /^(css)/,
        "css/admin.css": [
            "vendor/css/bootstrap.min.css",
            "vendor/css/admin_lte2.css",
            "vendor/css/all-skins.css",
            "vendor/css/skin-blue.css",
            "vendor/css/font-awesome.min.css",
            "vendor/css/ionicons.min.css"
        ],
      },
      order: {
        after: ["css/app.css"] // concat app.css last
      }
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true
  }
};
