# Copyright (C) 2011 by Wayne Walker <wwalker@solid-constructs.com>
#
# Released under one of the versions of the MIT License.
#
# Copyright (C) 2011 by Wayne Walker <wwalker@solid-constructs.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


##################################################################################
# Converted to FiSH.
# Original BASH version here: https://github.com/wwalker/ssh-find-agent/blob/master/ssh-find-agent.sh
##################################################################################

function _debug_print
    if test count $argv -gt 0 
        printf "%s\n" $argv[1]
    end
end

function find_all_ssh_agent_sockets
    set -g _SSH_AGENT_SOCKETS (find /tmp/ -type s -name agent.\* 2> /dev/null | grep '/tmp/ssh-.*/agent.*')
end

function find_all_gpg_agent_sockets
    set -g _GPG_AGENT_SOCKETS (find /tmp/ -type s -name S.gpg-agent.ssh 2> /dev/null | grep '/tmp/gpg-.*/S.gpg-agent.ssh')
end

function find_all_gnome_keyring_agent_sockets
    set -g _GNOME_KEYRING_AGENT_SOCKETS (find /tmp/ -type s -name ssh 2> /dev/null | grep '/tmp/keyring-.*/ssh$')
end

function find_all_osx_keychain_agent_sockets
    if test -n "$TMPDIR" 
        set -g _OSX_KEYCHAIN_AGENT_SOCKETS (find $TMPDIR/ -type s -regex '.*/ssh-.*/agent..*$'  2> /dev/null)
    else
        set -g TMPDIR /tmp
    end
end

function do_live_agent_list
    if test -n $_LIVE_AGENT_LIST
        set -x _LIVE_AGENT_LIST "$_LIVE_AGENT_LIST $SOCKET:$_KEY_COUNT"
    else
        set -x _LIVE_AGENT_LIST "$SOCKET:$_KEY_COUNT"
    end
end

function test_agent_socket
    set -x SOCKET $argv[1]
    set -g SSH_AUTH_SOCK (ssh-add -l 2> /dev/null > /dev/null)
    set -l result $status

    if test $result -eq 0
        # contactible and has keys loaded
        set -g _KEY_COUNT (set -x SSH_AUTH_SOCK $SOCKET ssh-add -l | wc -l | tr -d ' ')
    end

    if test $result -eq 1
        # contactible butno keys loaded
        set -g _KEY_COUNT 0
    end

    if test $result -eq 0 -o $result -eq 1
        do_live_agent_list
        return 0
    end

    return 1
end

function find_live_gnome_keyring_agents
    for i in $_GNOME_KEYRING_AGENT_SOCKETS
        test_agent_socket $i
    end
end

function find_live_osx_keychain_agents
    for i in $_OSX_KEYCHAIN_AGENT_SOCKETS
        test_agent_socket $i
    end
end

function find_live_gpg_agents
    for i in $_GPG_AGENT_SOCKETS
        test_agent_socket $i
    end
end

function find_live_ssh_agents
    for i in $_SSH_AGENT_SOCKETS
        test_agent_socket $i
    end
end

function find_all_agent_sockets
    #set -x _LIVE_AGENT_LIST ""
    #find_all_ssh_agent_sockets
    #find_all_gpg_agent_sockets
    #find_all_gnome_keyring_agent_sockets
    #find_all_osx_keychain_agent_sockets
    #find_live_ssh_agents
    #find_live_gpg_agents
    #find_live_gnome_keyring_agents
    #find_live_osx_keychain_agents
    #printf "%s\n" "$_LIVE_AGENT_LIST" | sed -e 's/ /\n/g' | sort -n -t: -k 2 -k 1
end

function set_ssh_agent_socket
  set -x SSH_AUTH_SOCK (find_all_agent_sockets|tail -n 1|awk -F: '{print $1}')
end
