'use strict';
Vue.component("suggestions", {
  template : "#suggestions_template",
  props : ["message", "suggestions"],
  data : function() {
    return {};
  },
  computed : {
    currentSuggestions : function() {
      if (this.message === "") {
        return [];
      }
      const pipelets = this.suggestions.filter((kw) => {
        if (!kw.name.startsWith(this.message)) {
          const plaintext = kw.name.split(" ");
          const noParts = this.message.split(" ");
          for (let i = 0; i < noParts.length; i = i + 1) {
            if (i >= plaintext.length) {
              return i < plaintext.length + kw.params.length;
            }
            if (plaintext[i] !== noParts[i]) {
              return false;
            }
          }
        }
        return true;
      }).slice(0, CONFIG.suggestionLimit);
      pipelets.forEach((route) => {
        /** @type {boolean} */
        route.disabled = !route.name.startsWith(this.message);
        route.params.forEach((showCalloutAnimation, searchSortBy) => {
          const objStr = searchSortBy === route.params.length - 1 ? "." : "\\S";
          const e = new RegExp(`${""}${route.name}${" (?:\\\\w+ ){"}${searchSortBy}${"}(?:"}${objStr}${"*)$"}`, "g");
          /** @type {boolean} */
          showCalloutAnimation.disabled = this.message.match(e) == null;
        });
      });
      return pipelets;
    }
  },
  methods : {}
});
