Wallarm WAF Gentoo Overlay
========================

Wallarm WAF, https://wallarm.com

Wallarm is a Next Gen WAF with hybrid architecture uniquely suited for cloud applications.

Using repository with newer portage
-----------------------------------

A package manager with git repository support can be used for sync.
Portage version 2.2.16 and later supports git sync.

The `repos.conf` entry for repository sync may look like the following:

    [wallarm]
    location = /usr/local/portage/wallarm
    sync-type = git
    sync-uri = https://github.com/rbkmoney/wallarm-overlay.git
    auto-sync = true

Please note that if you use existing repository location, you *need to
remove the existing repository first*.

