#!/bin/sh -ex
find . -print0 | cpio --null --create --verbose --format=newc
