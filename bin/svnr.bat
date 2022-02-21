@echo off
svn revert -R .
svn cleanup --remove-unversioned .
