#!/usr/bin/env python
# coding=utf-8
from pytest import fixture

from sample_module.example import redis_cache


@fixture
def r(request):
    """:type request: _pytest.python.FixtureRequest"""
    handle = redis_cache()
    request.addfinalizer(handle._cleanup)
    return handle


def test_redislite_can_set(r):
    assert r.set('foo', 'bar') is True
    assert r.get('foo') == b'bar'
