angular.module("templates").run(["$templateCache",function($templateCache){$templateCache.put("/plugins/threefold-auth/threefold-auth.html",'\n<div tg-threefold-login-button="tg-threefold-login-button"><a href="" title="Login with 3Bot" class="button button-auth"><span>Login with 3Bot</span></a></div>')}]),function(){var ThreeFoldLoginButtonDirective,module;ThreeFoldLoginButtonDirective=function($window,$params,$location,$config,$events,$confirm,$auth,$navUrls,$loader){var link;return link=function($scope,$el,$attrs){var STATE_CHARS,app_id,auth_url,generate_state,loginOnError,loginOnSuccess,loginWithThreeFoldAccount,pub_key,scope;return auth_url=$config.get("threeFoldUrl","https://login.threefold.me"),app_id=$config.get("threeFoldAppId",null),pub_key=$config.get("threeFoldAppPubKey",null),scope=$config.get("scope",'{"user": true, "email": true}'),STATE_CHARS="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split(""),generate_state=function(){var chars,i,r,rnd,state;for(chars=STATE_CHARS,state=new Array(32),rnd=0,i=0;i<32;)14===i?state[i]="4":(rnd<=2&&(rnd=33554432+16777216*Math.random()|0),r=15&rnd,rnd>>=4,state[i]=chars[19===i?3&r|8:r]),i++;return state.join("")},loginOnSuccess=function(response){var nextUrl;return nextUrl=$params.next&&$params.next!==$navUrls.resolve("login")?$params.next:$navUrls.resolve("home"),$events.setupConnection(),$location.search("next",null),$location.search("signedAttempt",null),$location.path(nextUrl)},loginOnError=function(response){return $location.search("signedAttempt",null),$loader.pageLoaded(),response.data._error_message?$confirm.notify("light-error",response.data._error_message):$confirm.notify("light-error","Our Oompa Loompas have not been able to get you credentials from ThreeFold.")},loginWithThreeFoldAccount=function(){var data,redirectUri,signedAttempt,state,token,type,url;if(type="threefold",signedAttempt=$params.signedAttempt,token=null,signedAttempt&&$window.sessionStorage.getItem("state"))return $loader.start(!0),url=document.createElement("a"),url.href=$location.absUrl(),redirectUri=url.protocol+"//"+url.hostname+(""===url.port?"":":"+url.port)+window.taigaConfig.baseHref+"login",state=$window.sessionStorage.getItem("state"),sessionStorage.removeItem("state"),data={signedAttempt:signedAttempt,state:state,redirectUri:redirectUri},$auth.login(data,type).then(loginOnSuccess,loginOnError)},loginWithThreeFoldAccount(),$el.on("click",".button-auth",function(event){var redirectToUri,state,url;return url=document.createElement("a"),url.href=$location.absUrl(),app_id||(app_id=""+url.hostname+(""===url.port?"":":"+url.port)),redirectToUri="login",state=generate_state(),$window.sessionStorage.setItem("state",state),url=auth_url+"?appid="+app_id+"&state="+state+"&publickey="+pub_key+"&scope="+scope+"&redirecturl="+redirectToUri,$window.location.href=url}),$scope.$on("$destroy",function(){return $el.off()})},{link:link,restrict:"EA",template:""}},module=angular.module("taigaContrib.threefoldAuth",[]),module.directive("tgThreefoldLoginButton",["$window","$routeParams","$tgLocation","$tgConfig","$tgEvents","$tgConfirm","$tgAuth","$tgNavUrls","tgLoader",ThreeFoldLoginButtonDirective])}.call(this);