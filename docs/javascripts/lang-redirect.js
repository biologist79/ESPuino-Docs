/* Leitet beim allerersten Besuch einmalig auf die Sprache weiter, die der Browser
   bevorzugt (falls unterstützt) - basierend auf den Links im Material-Sprachumschalter
   (.md-select__link[hreflang]), die mkdocs-static-i18n ohnehin pro Seite mitliefert.
   Eine manuelle Sprachwahl (Klick im Umschalter) merkt sich das Skript dauerhaft und
   greift danach nie wieder ein. */
(function () {
  "use strict";
  var STORAGE_KEY = "espuino-lang-redirect-done";

  function normalize(code) {
    if (!code) return null;
    return code.slice(0, 2).toLowerCase();
  }

  function preferredLocale(supported) {
    var candidates =
      navigator.languages && navigator.languages.length
        ? navigator.languages
        : [navigator.language || navigator.userLanguage];
    for (var i = 0; i < candidates.length; i++) {
      var code = normalize(candidates[i]);
      if (code && supported.indexOf(code) !== -1) {
        return code;
      }
    }
    return null;
  }

  document.addEventListener("DOMContentLoaded", function () {
    var links = document.querySelectorAll(".md-select__link[hreflang]");
    if (!links.length) return;

    // Ein bewusster Klick im Umschalter gewinnt ab sofort immer.
    links.forEach(function (link) {
      link.addEventListener("click", function () {
        try {
          localStorage.setItem(STORAGE_KEY, "1");
        } catch (e) {}
      });
    });

    try {
      if (localStorage.getItem(STORAGE_KEY)) return;
    } catch (e) {
      return; // kein localStorage (z. B. privater Modus) -> nie automatisch umleiten
    }

    var current = document.documentElement.lang;
    var targets = {};
    links.forEach(function (link) {
      targets[link.getAttribute("hreflang")] = link.getAttribute("href");
    });

    var preferred = preferredLocale(Object.keys(targets));

    try {
      localStorage.setItem(STORAGE_KEY, "1");
    } catch (e) {}

    if (preferred && preferred !== current && targets[preferred]) {
      window.location.replace(targets[preferred]);
    }
  });
})();
