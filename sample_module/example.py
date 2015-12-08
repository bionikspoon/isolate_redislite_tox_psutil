# -*- coding: utf-8 -*-
import redislite


def redis_cache():
    return redislite.StrictRedis()
