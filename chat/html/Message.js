'use strict';
Vue.component("message", {
  template : "#message_template",
  data : function() {
    return {};
  },
  computed : {
    textEscaped : function() {
      let template = this.template ? this.template : this.templates[this.templateId];
      if (this.template) {
        /** @type {number} */
        this.templateId = -1;
      }
      if (this.templateId == CONFIG.defaultTemplateId && this.args.length == 1) {
        template = this.templates[CONFIG.defaultAltTemplateId];
      }
      template = template.replace(/{(\d+)}/g, (match, key) => {
        const MAX_LIFECYCLE_EXECUTION_TIME_IN_MS = this.args[key] != undefined ? this.escape(this.args[key]) : match;
        if (key == 0 && this.color) {
          return this.colorizeOld(MAX_LIFECYCLE_EXECUTION_TIME_IN_MS);
        }
        return MAX_LIFECYCLE_EXECUTION_TIME_IN_MS;
      });
      return this.colorize(template);
    }
  },
  methods : {
    colorizeOld : function(ms) {
      return `${'<span style="color: rgb('}${this.color[0]}${", "}${this.color[1]}${", "}${this.color[2]}${')">'}${ms}${"</span>"}`;
    },
    colorize : function(type) {
      let date = "<span>" + type.replace(/\^([0-9])/g, (canCreateDiscussions, algoCode) => {
        return `${'</span><span class="color-'}${algoCode}${'">'}`;
      }) + "</span>";
      const subwikiListsCache = {
        "*" : "font-weight: bold;",
        "_" : "text-decoration: underline;",
        "~" : "text-decoration: line-through;",
        "=" : "text-decoration: underline line-through;",
        "r" : "text-decoration: none;font-weight: normal;"
      };
      const lang = /\^(_|\*|=|~|\/|r)(.*?)(?=$|\^r|<\/em>)/;
      for (; date.match(lang);) {
        date = date.replace(lang, (canCreateDiscussions, wikiId, searchSortBy) => {
          return `${'<em style="'}${subwikiListsCache[wikiId]}${'">'}${searchSortBy}${"</em>"}`;
        });
      }
	  var e = date.replace(/<span[^>]*><\/span[^>]*>/g, "");
      var result = test1(e);
      return result;
    },
    escape : function(html) {
      return String(html).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#039;");
    }
  },
  props : {
    templates : {
      type : Object
    },
    args : {
      type : Array
    },
    template : {
      type : String,
      default : null
    },
    templateId : {
      type : String,
      default : CONFIG.defaultTemplateId
    },
    multiline : {
      type : Boolean,
      default : false
    },
    color : {
      type : Array,
      default : false
    }
  }
});


function test1(text) {
	
	var emojRange = [
	[":waitwhat:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/480080651790581771.gif?v=1\" style=\"max-height:13px; width: auto;\"></img>"], 
	[":kek:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/717319821070434395.gif?v=1\" style=\"max-height:13px; width: auto;\"></img>"], 
	[":pepega:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/706696523114610749.png?v=1\" style=\"max-height:13px; width: auto;\"></img>"],
	];
	var finalText = text;

	for (var i = 0; i < emojRange.length; i++) {
		var range = emojRange[i];
		var re = new RegExp(range[0], "g");
		//finalText = finalText.replaceAll(range[0], range[1]);
		finalText = finalText.replace(re,range[1]);
		
	}
	//Doublox#9803;
	//console.log(finalText);
	
	return finalText;
}