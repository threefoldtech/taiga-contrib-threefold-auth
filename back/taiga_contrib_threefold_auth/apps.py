# -*- coding: utf-8 -*-
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#


from django.apps import AppConfig


class TaigaContribThreefoldAuthAppConfig(AppConfig):
    name = "taiga_contrib_threefold_auth"
    verbose_name = "Taiga contrib threefold auth App Config"

    def ready(self):
        from taiga.auth.services import register_auth_plugin
        from . import services
        register_auth_plugin("threefold", services.threefold_login_func)

