if(!UserVoice){var UserVoice={};}
UserVoice.Util={sslAssetHost:"https://cdn.uservoice.com",assetHost:"http://cdn.uservoice.com",getAssetHost:function(){return("https:"==document.location.protocol)?this.sslAssetHost:this.assetHost;},render:function(template,params){return template.replace(/\#{([^{}]*)}/g,function(a,b){var r=params[b];return typeof r==='string'||typeof r==='number'?r:a;})},toQueryString:function(params){var pairs=[];for(key in params){if(params[key]!=null&&params[key]!=''){pairs.push([key,params[key]].join('='));}}
return pairs.join('&');},isIE:function(test){if(/MSIE (\d+\.\d+);/.test(navigator.userAgent)){if(typeof test==="function"){return test(new Number(RegExp.$1));}else{return true;}}else{return false;}},isQuirksMode:function(){return document.compatMode&&document.compatMode=="BackCompat";},includeCss:function(css){var styleElement=document.createElement('style');styleElement.setAttribute('type','text/css');styleElement.setAttribute('media','screen');if(styleElement.styleSheet){styleElement.styleSheet.cssText=css;}else{styleElement.appendChild(document.createTextNode(css));}
document.getElementsByTagName('head')[0].appendChild(styleElement);}}
UserVoice.Page={getDimensions:function(){var de=document.documentElement;var width=window.innerWidth||self.innerWidth||(de&&de.clientWidth)||document.body.clientWidth;var height=window.innerHeight||self.innerHeight||(de&&de.clientHeight)||document.body.clientHeight;return{width:width,height:height};}}
UserVoice.Dialog={preload:function(id_or_html){if(!this.preloaded){var element=document.getElementById(id_or_html);var html=(element==null)?id_or_html:element.innerHTML;this.setContent(html);this.preloaded=true;}},show:function(id_or_html){if(!this.preloaded){this.preload(id_or_html);}
this.Overlay.show();this.setPosition();UserVoice.Element.addClassName(this.htmlElement(),'dialog-open');this.element().style.display='block';this.preloaded=false;this.element().focus();},close:function(){var change=UserVoice.needsConfirm;if(change){var answer=confirm(change);if(!answer){return}}
this.element().style.display='none';UserVoice.Element.removeClassName(this.htmlElement(),'dialog-open');this.Overlay.hide();UserVoice.onClose();},id:'uservoice-dialog',css_template:"\
    #uservoice-dialog {\
      z-index: 100003;\
      display: block;\
      text-align: left;\
      margin: -2em auto 0 auto;\
      position: fixed; \
    }\
    \
    #uservoice-overlay {\
      position: fixed;\
      z-index:100002;\
      width: 100%;\
      height: 100%;\
      left: 0;\
      top: 0;\
      background-color: #000;\
      opacity: .7;\
      filter: alpha(opacity=70);\
    }\
    \
    #uservoice-overlay p {\
      padding: 5px;\
      color: #ddd;\
      font: bold 14px arial, sans-serif;\
      margin: 0;\
      letter-spacing: -1px;\
    }\
    \
    #uservoice-dialog #uservoice-dialog-close {\
      position: absolute;\
      height: 48px;\
      width: 48px;\
      top: -11px;\
      right: -12px;\
      color: #06c;\
      cursor: pointer;\
      background-position: 0 0;\
      background-repeat: no-repeat;\
      background-color: transparent;\
    }\
    \
    html.dialog-open object,\
    html.dialog-open embed {\
      visibility: hidden;\
    }\
    a#uservoice-dialog-close { background-image: url(#{background_image_url}); }"+((UserVoice.Util.isIE()&&(UserVoice.Util.isIE(function(v){return v<7})||(UserVoice.Util.isIE(function(v){return v>=7})&&UserVoice.Util.isQuirksMode())))?"\
    #uservoice-overlay,\
    #uservoice-dialog {\
      position: absolute;\
    }\
    \
    .dialog-open,\
    .dialog-open body {\
      overflow: hidden;\
    }\
    \
    .dialog-open body {\
      height: 100%;\
    }\
    #uservoice-overlay {\
      width: 100%;\
    }\
    \
    #uservoice-dialog #uservoice-dialog-close {\
      background: none;\
      filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='https://uservoice.com/images/icons/close.png');\
    }\
    .dialog-open select {\
      visibility: hidden;\
    }\
    .dialog-open #uservoice-dialog select {\
      visibility: visible;\
    }":""),element:function(){if(!document.getElementById(this.id)){var dummy=document.createElement('div');dummy.innerHTML='<div id="'+this.id+'" class="uservoice-component" style="display:none;">'+'<a href="#close" onclick="UserVoice.Dialog.close(); return false;" id="'+this.id+'-close" title="Close Dialog"><span style="display: none;">Close Dialog</span></a>'+'<div id="'+this.id+'-content"></div></div>';if(document.getElementById('uservoice-feedback')){document.getElementById('uservoice-feedback').insertBefore(dummy.firstChild,document.getElementById('uservoice-feedback').firstChild.nextSibling);}else{document.body.insertBefore(dummy.firstChild,document.body.firstChild);}}
return document.getElementById(this.id);},setContent:function(html){this.element()
if(typeof(Prototype)!='undefined'){document.getElementById(this.id+"-content").innerHTML=html.stripScripts();setTimeout(function(){html.evalScripts()},100);}else{document.getElementById(this.id+"-content").innerHTML=html;}},setPosition:function(){var dialogDimensions=UserVoice.Element.getDimensions(this.element());var pageDimensions=UserVoice.Page.getDimensions();var els=this.element().style;els.width='auto';els.height='auto';els.left=((pageDimensions.width-dialogDimensions.width)/2)+"px";els.top=((pageDimensions.height-dialogDimensions.height)/2)+"px";},htmlElement:function(){return document.getElementsByTagName('html')[0];}}
UserVoice.Dialog.Overlay={show:function(){this.element().style.display='block';},hide:function(){this.element().style.display='none';},id:'uservoice-overlay',element:function(){if(!document.getElementById(this.id)){var dummy=document.createElement('div');dummy.innerHTML='<div id="'+this.id+'" class="uservoice-component" onclick="UserVoice.Dialog.close(); return false;" style="display:none;"></div>';document.body.insertBefore(dummy.firstChild,document.body.firstChild);}
return document.getElementById(this.id);}}
UserVoice.Element={getDimensions:function(element){var display=element.display;if(display!='none'&&display!=null){return{width:element.offsetWidth,height:element.offsetHeight};}
var els=element.style;var originalVisibility=els.visibility;var originalPosition=els.position;var originalDisplay=els.display;els.visibility='hidden';els.position='absolute';els.display='block';var originalWidth=element.clientWidth;var originalHeight=element.clientHeight;els.display=originalDisplay;els.position=originalPosition;els.visibility=originalVisibility;return{width:originalWidth,height:originalHeight};},hasClassName:function(element,className){var elementClassName=element.className;return(elementClassName.length>0&&(elementClassName==className||new RegExp("(^|\\s)"+className+"(\\s|$)").test(elementClassName)));},addClassName:function(element,className){if(!this.hasClassName(element,className)){element.className+=(element.className?' ':'')+className;}
return element;},removeClassName:function(element,className){element.className=element.className.replace(new RegExp("(^|\\s+)"+className+"(\\s+|$)"),' ');return element;}}
UserVoice.needsConfirm=false;UserVoice.onClose=function(){};UserVoice.Util.includeCss(UserVoice.Util.render(UserVoice.Dialog.css_template,{background_image_url:UserVoice.Util.getAssetHost()+'/images/icons/close.png'}));MixpanelLib=function(q){metrics={};metrics.super_properties={"all":{},"events":{},"funnels":{}};metrics.init=function(a){var b=(("https:"==document.location.protocol)?"https://":"http://");metrics.token=a;metrics.api_host=b+'api.mixpanel.com';try{metrics.get_super()}catch(err){}};metrics.send_request=function(a,b){var c='mpmetrics.jsonp_callback';if(a.indexOf("?")>-1){a+="&callback="}else{a+="?callback="}a+=c+"&";if(b){a+=metrics.http_build_query(b)}a+='&_='+new Date().getTime().toString();var d=document.createElement("script");d.setAttribute("src",a);d.setAttribute("type","text/javascript");document.body.appendChild(d)};metrics.log=function(a,b){if(!a.project){a.project=metrics.token}if(a.project&&a.category){metrics.callback=b;a.ip=1;metrics.send_request(metrics.api_host+"/log/",a)}};metrics.track_funnel=function(a,b,c,d,e){if(!d){d={}}d.funnel=a;d.step=parseInt(b,10);d.goal=c;if(d.step==1){if(document.referrer.search('http://(.*)google.com')===0){var f=metrics.get_query_param(document.referrer,'q');if(f.length){metrics.register({'mp_keyword':f},'funnels')}}}metrics.track('mp_funnel',d,e,"funnels")};metrics.get_query_param=function(a,b){b=b.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");var c="[\\?&]"+b+"=([^&#]*)";var d=new RegExp(c);var e=d.exec(a);if(e===null||(e&&typeof(e[1])!='string'&&e[1].length)){return''}else{return unescape(e[1]).replace(/\+/g,' ')}};metrics.track=function(a,b,c,d){if(!d){d="events"}if(!b){b={}}if(!b.token){b.token=metrics.token}if(c){metrics.callback=c}b.time=metrics.get_unixtime();if(d!="all"){for(var p in metrics.super_properties[d]){if(!b[p]){b[p]=metrics.super_properties[d][p]}}}if(metrics.super_properties.all){for(p in metrics.super_properties.all){if(!b[p]){b[p]=metrics.super_properties.all[p]}}}var e={'event':a,'properties':b};var f=metrics.base64_encode(metrics.json_encode(e));metrics.send_request(metrics.api_host+'/track/',{'data':f,'ip':1})};metrics.register_once=function(a,b,c,d){if(!b||!metrics.super_properties[b]){b="all"}if(!c){c="None"}if(!d){d=7}if(a){for(var p in a){if(p){if(!metrics.super_properties[b][p]||metrics.super_properties[b][p]==c){metrics.super_properties[b][p]=a[p]}}}}metrics.set_cookie("mp_super_properties",metrics.json_encode(metrics.super_properties),d)};metrics.register=function(a,b,c){if(!b||!metrics.super_properties[b]){b="all"}if(!c){c=7}if(a){for(var p in a){if(p){metrics.super_properties[b][p]=a[p]}}}metrics.set_cookie("mp_super_properties",metrics.json_encode(metrics.super_properties),c)};metrics.http_build_query=function(a,b){var c,use_val,use_key,i=0,tmp_arr=[];if(!b){b='&'}for(c in a){if(c){use_val=encodeURIComponent(a[c].toString());use_key=encodeURIComponent(c);tmp_arr[i++]=use_key+'='+use_val}}return tmp_arr.join(b)};metrics.get_unixtime=function(){return parseInt(new Date().getTime().toString().substring(0,10),10)};metrics.jsonp_callback=function(a){if(metrics.callback){metrics.callback(a);metrics.callback=false}};metrics.json_encode=function(j){var l;var m=j;var i;var n=function(b){var d=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;var e={'\b':'\\b','\t':'\\t','\n':'\\n','\f':'\\f','\r':'\\r','"':'\\"','\\':'\\\\'};d.lastIndex=0;return d.test(b)?'"'+b.replace(d,function(a){var c=e[a];return typeof c==='string'?c:'\\u'+('0000'+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+b+'"'};var o=function(a,b){var c='';var d='    ';var i=0;var k='';var v='';var e=0;var f=c;var g=[];var h=b[a];if(h&&typeof h==='object'&&typeof h.toJSON==='function'){h=h.toJSON(a)}switch(typeof h){case'string':return n(h);case'number':return isFinite(h)?String(h):'null';case'boolean':case'null':return String(h);case'object':if(!h){return'null'}c+=d;g=[];if(Object.prototype.toString.apply(h)==='[object Array]'){e=h.length;for(i=0;i<e;i+=1){g[i]=o(i,h)||'null'}v=g.length===0?'[]':c?'[\n'+c+g.join(',\n'+c)+'\n'+f+']':'['+g.join(',')+']';c=f;return v}for(k in h){if(Object.hasOwnProperty.call(h,k)){v=o(k,h);if(v){g.push(n(k)+(c?': ':':')+v)}}}v=g.length===0?'{}':c?'{'+g.join(',')+''+f+'}':'{'+g.join(',')+'}';c=f;return v}};return o('',{'':m})};metrics.base64_encode=function(a){var b="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";var c,o2,o3,h1,h2,h3,h4,bits,i=0,ac=0,enc="",tmp_arr=[];if(!a){return a}a=metrics.utf8_encode(a+'');do{c=a.charCodeAt(i++);o2=a.charCodeAt(i++);o3=a.charCodeAt(i++);bits=c<<16|o2<<8|o3;h1=bits>>18&0x3f;h2=bits>>12&0x3f;h3=bits>>6&0x3f;h4=bits&0x3f;tmp_arr[ac++]=b.charAt(h1)+b.charAt(h2)+b.charAt(h3)+b.charAt(h4)}while(i<a.length);enc=tmp_arr.join('');switch(a.length%3){case 1:enc=enc.slice(0,-2)+'==';break;case 2:enc=enc.slice(0,-1)+'=';break}return enc};metrics.utf8_encode=function(a){a=(a+'').replace(/\r\n/g,"\n").replace(/\r/g,"\n");var b="";var c,end;var d=0;c=end=0;d=a.length;for(var n=0;n<d;n++){var e=a.charCodeAt(n);var f=null;if(e<128){end++}else if((e>127)&&(e<2048)){f=String.fromCharCode((e>>6)|192)+String.fromCharCode((e&63)|128)}else{f=String.fromCharCode((e>>12)|224)+String.fromCharCode(((e>>6)&63)|128)+String.fromCharCode((e&63)|128)}if(f!==null){if(end>c){b+=a.substring(c,end)}b+=f;c=end=n+1}}if(end>c){b+=a.substring(c,a.length)}return b};metrics.set_cookie=function(a,b,c){var d=new Date();d.setDate(d.getDate()+c);document.cookie=a+"="+escape(b)+((c===null)?"":";expires="+d.toGMTString())+"; path=/"};metrics.get_cookie=function(a){if(document.cookie.length>0){var b=document.cookie.indexOf(a+"=");if(b!=-1){b=b+a.length+1;var c=document.cookie.indexOf(";",b);if(c==-1){c=document.cookie.length}return unescape(document.cookie.substring(b,c))}}return""};metrics.get_super=function(){var a=eval('('+metrics.get_cookie("mp_super_properties")+')');if(a){for(var i in a){if(i){metrics.super_properties[i]=a[i]}}}};metrics.init(q);return metrics}
if(!UserVoice){var UserVoice={};}
UserVoice.Logger={_log:function(message){if(typeof console!=="undefined"&&typeof console.log!=="undefined"){try{console.log(message);}catch(e){}}},warning:function(message){this._log("UserVoice WARNING: "+message);},error:function(message){this._log("UserVoice ERROR: "+message);alert("UserVoice ERROR: "+message);}};UserVoice.Util={sslAssetHost:"https://cdn.uservoice.com",assetHost:"http://cdn.uservoice.com",getAssetHost:function(){return("https:"==document.location.protocol)?this.sslAssetHost:this.assetHost;},render:function(template,params){return template.replace(/\#{([^{}]*)}/g,function(a,b){var r=params[b];return typeof r==='string'||typeof r==='number'?r:a;})},toQueryString:function(params){var pairs=[];for(key in params){if(params[key]!=null&&params[key]!=''){pairs.push([key,params[key]].join('='));}}
return pairs.join('&');},isIE:function(test){if(/MSIE (\d+\.\d+);/.test(navigator.userAgent)){if(typeof test==="function"){return test(new Number(RegExp.$1));}else{return true;}}else{return false;}},isQuirksMode:function(){return document.compatMode&&document.compatMode=="BackCompat";},includeCss:function(css){var styleElement=document.createElement('style');styleElement.setAttribute('type','text/css');styleElement.setAttribute('media','screen');if(styleElement.styleSheet){styleElement.styleSheet.cssText=css;}else{styleElement.appendChild(document.createTextNode(css));}
document.getElementsByTagName('head')[0].appendChild(styleElement);}}
UserVoice.Popin={content_template:'<iframe src="#{url}/widgets/#{dialog}.html?#{query}" frameborder="0" scrolling="no" allowtransparency="true" width="#{width}" height="#{height}" style="height: #{height}; width: #{width};"></iframe>',setup:function(options){this.setupOptions(options);},setupOptions:function(options){if(typeof(options)==='undefined'){return;}
if(options.key==null&&options.host==null){UserVoice.Logger.error("'host' must be set.");UserVoice.Logger.error("'key' must be set.");}else if(options.key==null){UserVoice.Logger.warning("'key' must be set for the widget to work with SSL.")}
if(options.forum==null){UserVoice.Logger.error("'forum' must be set.");}
if(!options.params){options.params={};}
this.options=options;},preload:function(options){this.setupOptions(options);UserVoice.Dialog.preload(UserVoice.Util.render(this.content_template,this.getContext()));},show:function(options){this.setupOptions(options);UserVoice.Dialog.show(UserVoice.Util.render(this.content_template,this.getContext()));},getContext:function(){var context={dialog:'popin',width:'350px',height:'430px',lang:'en'};for(attr in this.options){context[attr]=this.options[attr]};context.url=this.url();context.params.lang=this.options.lang;context.params.referer=this.getReferer();context.query=UserVoice.Util.toQueryString(context.params);return context;},getReferer:function(){var referer=window.location.href;if(referer.indexOf('?')!=-1){referer=referer.substring(0,referer.indexOf('?'));}
return referer;},url:function(){if("https:"==document.location.protocol&&this.options.key!=null){var url='https://'+this.options.key+'.uservoice.com/forums/'+this.options.forum;}else{var url='http://'+this.options.host+'/forums/'+this.options.forum;}
return url;}}
UserVoice.Tab={id:"uservoice-feedback-tab",css_template:"\
    body a#uservoice-feedback-tab,\
    body a#uservoice-feedback-tab:link {\
      background-position: 2px 50% !important;\
      position: fixed !important;\
      top: 45% !important;\
      display: block !important;\
      width: 25px !important;\
      height: 98px !important;\
      margin: -45px 0 0 0 !important;\
      padding: 0 !important;\
      z-index: 100001 !important;\
      background-position: 2px 50% !important;\
      background-repeat: no-repeat !important;\
      text-indent: -9000px;\
    }\
    \
    body a#uservoice-feedback-tab:hover {\
      cursor: pointer;\
    }\
    \
    a##{id} { \
      #{alignment}: 0; \
      background-repeat: no-repeat; \
      background-color: #{background_color}; \
      background-image: url(#{text_url}); \
      border: outset 1px #{background_color}; \
      border-#{alignment}: none; \
    }\
    \
    a##{id}:hover { \
      background-color: #{hover_color}; \
      border: outset 1px #{hover_color}; \
      border-#{alignment}: none; \
    }"+((UserVoice.Util.isIE()&&(UserVoice.Util.isIE(function(v){return v<7})||(UserVoice.Util.isIE(function(v){return v>=7})&&UserVoice.Util.isQuirksMode())))?"\
    body a#uservoice-feedback-tab,\
    body a#uservoice-feedback-tab:link {\
      position: absolute !important;\
      background-image: none !important;\
    }\
    a##{id} { filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='#{text_url}'); }":""),show:function(options){this.setupOptions(options||{});UserVoice.Popin.setup(options);var html='<a id="'+this.id+'"';if(!this.options.no_dialog){html+='" onclick="UserVoice.Popin.show(); UserVoice.Metrics.track(\'tab_click_conversion\', 2, \'Tab Click\'); return false;" onkeydown="UserVoice.Tab.onKeyDown(event);"';if(this.options.preload){html+='" onmouseover="UserVoice.Popin.preload(); UserVoice.Metrics.track(\'tab_click_conversion\', 1, \'Tab Hover\');"';}}
html+=' href="'+UserVoice.Popin.url()+'">'+(this.options.tab_string[this.options.lang]?this.options.tab_string[this.options.lang]:'Open Feedback Dialog')+'</a>';var tab=document.createElement('div');tab.setAttribute('id','uservoice-feedback');tab.innerHTML=html;document.body.insertBefore(tab,document.body.firstChild);if(!this.options.no_styles){UserVoice.Util.includeCss(UserVoice.Util.render(this.css_template,this.options));}},onKeyDown:function(e){if(!e)e=window.event;key=e.keycode?e.keycode:e.which;if(key==13){UserVoice.Popin.show();return false;}},setupOptions:function(options){this.options={alignment:'left',background_color:'#f00',text_color:'white',hover_color:'#06C',lang:'en',no_styles:false,no_dialog:false,preload:true}
for(attr in options){this.options[attr]=options[attr];}
this.options.tab_string={cn:"反馈",de:"Feedback",es:"Sugerencias",fi:"Palaute",fr:"Commentaires",ja:"フィードバック",nl:"Feedback",pt_BR:"Comentário"};this.options.text_url=UserVoice.Util.getAssetHost()+'/images/widgets/'+(this.options.tab_string[this.options.lang]?this.options.lang:'en')+'/feedback_tab_'+this.options.text_color+'.png';this.options.id=this.id;}}
UserVoice.Metrics={events:{},mpmetrics:null,enabled:true,track:function(funnel,step,name){if(this.enabled){if(!this.mpmetrics){this.mpmetrics=MixpanelLib('7a0a5074ecca7025afedfe04d9eb214f');}
if(!this.events[name]){this.mpmetrics.track(name);this.mpmetrics.track_funnel(funnel,2,name);this.events[name]=true;}}}}
UserVoice.Metrics.enabled=false;if(typeof(uservoiceOptions)!=='undefined'&&uservoiceOptions.showTab==true){UserVoice.Tab.show(uservoiceOptions);}