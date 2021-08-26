###
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

###

ThreeFoldLoginButtonDirective = ($window, $params, $location, $config, $events, $confirm,
                              $auth, $navUrls, $loader) ->
    # Login or registar a user with his/her threefold account.
    #
    # Example:
    #     tg-threefold-login-button()
    #
    # Requirements:
    #   - ...

    link = ($scope, $el, $attrs) ->
        auth_url = $config.get("threeFoldUrl", "https://login.threefold.me")
        app_id = $config.get("threeFoldAppId", null)
        pub_key = $config.get("threeFoldAppPubKey", null)
        scope = $config.get("scope", '{"user": true, "email": true}')

        STATE_CHARS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split("")

        generate_state = ->
            chars = STATE_CHARS
            state = new Array(32)
            rnd = 0
            i = 0

            while i < 32
                if i is 14
                    state[i] = "4"
                else
                    rnd = 0x2000000 + (Math.random() * 0x1000000) | 0  if rnd <= 0x02
                    r = rnd & 0xf
                    rnd = rnd >> 4
                    state[i] = chars[(if (i is 19) then (r & 0x3) | 0x8 else r)]
                i++

            state.join ""
            

        loginOnSuccess = (response) ->
            if $params.next and $params.next != $navUrls.resolve("login")
                nextUrl = $params.next
            else
                nextUrl = $navUrls.resolve("home")

            $events.setupConnection()

            $location.search("next", null)
            $location.search("signedAttempt", null)

            $location.path(nextUrl)

        loginOnError = (response) ->
            $location.search("signedAttempt", null)
            $loader.pageLoaded()

            if response.data._error_message
                $confirm.notify("light-error", response.data._error_message )
            else
                $confirm.notify("light-error", "Our Oompa Loompas have not been able to get you
                                                credentials from ThreeFold.")  #TODO: i18n

        loginWithThreeFoldAccount = ->
            type = "threefold"
            signedAttempt = $params.signedAttempt
            token = null
            return if not (signedAttempt and $window.sessionStorage.getItem("state"))
            $loader.start(true)

            url = document.createElement('a')
            url.href = $location.absUrl()
            redirectUri = "#{url.protocol}//#{url.hostname}#{if url.port == '' then '' else ':'+url.port}#{window.taigaConfig.baseHref}login"
            state = $window.sessionStorage.getItem("state")
            sessionStorage.removeItem('state');
            data = {signedAttempt: signedAttempt, state: state, redirectUri: redirectUri}
            $auth.login(data, type).then(loginOnSuccess, loginOnError)

        loginWithThreeFoldAccount()

        $el.on "click", ".button-auth", (event) ->
            url = document.createElement('a')
            url.href = $location.absUrl()
            if not app_id
                app_id = "#{url.hostname}#{if url.port == '' then '' else ':'+url.port}"
            redirectToUri = "login"
            state = generate_state()
            $window.sessionStorage.setItem("state", state)
            url = "#{auth_url}?appid=#{app_id}&state=#{state}&publickey=#{pub_key}&scope=#{scope}&redirecturl=#{redirectToUri}"
            $window.location.href = url

        $scope.$on "$destroy", ->
            $el.off()

    return {
        link: link
        restrict: "EA"
        template: ""
    }

module = angular.module('taigaContrib.threefoldAuth', [])
module.directive("tgThreefoldLoginButton", ["$window", '$routeParams', "$tgLocation", "$tgConfig", "$tgEvents",
                                         "$tgConfirm", "$tgAuth", "$tgNavUrls", "tgLoader",
                                         ThreeFoldLoginButtonDirective])
