#!/usr/bin/env python
# coding=utf-8
from sample_module.example import redis_cache


def test_redislite_can_set():
    r = redis_cache()
    assert r.set('foo', 'bar') is True
    assert r.get('foo') == b'bar'
