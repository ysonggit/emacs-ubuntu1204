#!/bin/sh

# Time-stamp: <04/10/2009 14:44:43 星期五 by Qnyd>

# @file (>>>FILE<<<)
# @version 1.0
# @author Qnyd

shuStringEqualMsg()
{
    message="${1:-}"
    [ x"${2}" = x"${3}" ]
    shuAssert "$message" $?
}

shuStringEqualNoMsg()
{
    [ x"${1}" = x"${2}" ]
    shuAssert "" $?
}

Test(>>>POINT<<<)()
{
}

. "$SHUNIT_HOME/shUnit"
. "$SHUNIT_HOME/shUnitPlus"
shuStart
