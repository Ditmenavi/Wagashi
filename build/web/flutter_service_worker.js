'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "e099659bfaf5f9f205a9d9951b570094",
"assets/assets/default-avatar.svg": "d1922c99d6acec0ba02f88c25ede75f0",
"assets/assets/icon-transparent-padding.png": "588c9ea78df0f7305c1c1ef009dd3922",
"assets/assets/icon-transparent.png": "4d02f30a50085949d7537fc171b6a65d",
"assets/assets/icon.png": "76a360612fc6231215502027d8bfe5ad",
"assets/assets/logo-01.svg": "bf483cc438b50b9be38e64a2f2dae325",
"assets/assets/Montserrat/Montserrat-Black.ttf": "27e3649bab7c62fa21b8837c4842e40e",
"assets/assets/Montserrat/Montserrat-BlackItalic.ttf": "d9b6ba595b059fc5d48e8f52c30f73b3",
"assets/assets/Montserrat/Montserrat-Bold.ttf": "ade91f473255991f410f61857696434b",
"assets/assets/Montserrat/Montserrat-BoldItalic.ttf": "1b38414956c666bd1df78fe5b9c84756",
"assets/assets/Montserrat/Montserrat-ExtraBold.ttf": "19ba7aa52a78c3896558ac1c0a5fb4c7",
"assets/assets/Montserrat/Montserrat-ExtraBoldItalic.ttf": "52a50ca037f2f96fa567404dc3c5bdfb",
"assets/assets/Montserrat/Montserrat-ExtraLight.ttf": "570a244cacd3d78b8c75ac5dd622f537",
"assets/assets/Montserrat/Montserrat-ExtraLightItalic.ttf": "1170df5548b7e238df5fa14b6f1a753e",
"assets/assets/Montserrat/Montserrat-Italic.ttf": "a7063e0c0f0cb546ad45e9e24b27bd3b",
"assets/assets/Montserrat/Montserrat-Light.ttf": "409c7f79a42e56c785f50ed37535f0be",
"assets/assets/Montserrat/Montserrat-LightItalic.ttf": "01c4560c9c15069b6700ce7ad2e49a9c",
"assets/assets/Montserrat/Montserrat-Medium.ttf": "c8b6e083af3f94009801989c3739425e",
"assets/assets/Montserrat/Montserrat-MediumItalic.ttf": "40a74702035bf9ef19053c84ce9a58b9",
"assets/assets/Montserrat/Montserrat-Regular.ttf": "ee6539921d713482b8ccd4d0d23961bb",
"assets/assets/Montserrat/Montserrat-SemiBold.ttf": "c641dbee1d75892e4d88bdc31560c91b",
"assets/assets/Montserrat/Montserrat-SemiBoldItalic.ttf": "83c1ec1f1db9a6416791f7d9d29536f2",
"assets/assets/Montserrat/Montserrat-Thin.ttf": "43dd5b7a3d277362d5e801e5353e3a01",
"assets/assets/Montserrat/Montserrat-ThinItalic.ttf": "3c2b290f95cd5b33c3ead2911064a2ab",
"assets/FontManifest.json": "09f8d46cc3a250825da56e6511765da9",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/NOTICES": "43edd9c9346b3f471869609b945d0d72",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b00363533ebe0bfdb95f3694d7647f6d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "0a94bab8e306520dc6ae14c2573972ad",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "9cda082bd7cc5642096b56fa8db15b45",
"favicon.png": "778cb3b6d278276f7ffe5b29583a0e34",
"icons/Icon-192.png": "919f41e2b3f0490e37df527af8162471",
"icons/Icon-512.png": "b6efcd0a5d423f2cd4625ba0db1682ce",
"icons/Icon-maskable-192.png": "919f41e2b3f0490e37df527af8162471",
"icons/Icon-maskable-512.png": "b6efcd0a5d423f2cd4625ba0db1682ce",
"index.html": "52d14b9ba59ed5d9edd7facf40dc001b",
"/": "52d14b9ba59ed5d9edd7facf40dc001b",
"main.dart.js": "935956fe7f96a89a485e581a3f7f30f6",
"manifest.json": "4354bffa9e9be3fefd9a7eeef369f097",
"version.json": "bca95ebed3687c9da6accb356fe2c74b"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}