/*
 * Copyright (c) 1996, 1998, 1999, 2001
 *	Todd C. Miller <Todd.Miller@courtesan.com>.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * 4. Products derived from this software may not be called "Sudo" nor
 *    may "Sudo" appear in their names without specific prior written
 *    permission from the author.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Sponsored in part by the Defense Advanced Research Projects
 * Agency (DARPA) and Air Force Research Laboratory, Air Force
 * Materiel Command, USAF, under agreement number F39502-99-1-0512.
 *
 * $Sudo: pathnames.h.in,v 1.46 2003/04/16 00:42:10 millert Exp $
 */

/*
 *  Pathnames to programs and files used by sudo.
 */

#ifdef HAVE_PATHS_H
#include <paths.h>
#endif /* HAVE_PATHS_H */

#ifndef _PATH_DEV
#define _PATH_DEV		"/dev/"
#endif /* _PATH_DEV */

#ifndef _PATH_TTY
#define _PATH_TTY		"/dev/tty"
#endif /* _PATH_TTY */

#ifndef _PATH_DEFPATH
#define _PATH_DEFPATH		"/usr/bin:/bin"
#endif /* _PATH_DEFPATH */

/*
 * NOTE: _PATH_SUDOERS is usually overriden by the Makefile.
 */
#ifndef _PATH_SUDOERS
#define _PATH_SUDOERS		"/etc/sudoers"
#endif /* _PATH_SUDOERS */

/*
 * NOTE:  _PATH_SUDOERS_TMP is usually overriden by the Makefile.
 *        _PATH_SUDOERS_TMP *MUST* be on the same partition
 *        as _PATH_SUDOERS!
 */
#ifndef _PATH_SUDOERS_TMP
#define _PATH_SUDOERS_TMP	"/etc/sudoers.tmp"
#endif /* _PATH_SUDOERS_TMP */

/*
 * The following paths are controlled via the configure script.
 */

/*
 * Where to put the timestamp files.  Defaults to /var/run/sudo if
 * /var/run exists, else /tmp/.odus.
 */
#ifndef _PATH_SUDO_TIMEDIR
#define _PATH_SUDO_TIMEDIR "/var/run/sudo"
#endif /* _PATH_SUDO_TIMEDIR */

/*
 * Where to put the sudo log file when logging to a file.  Defaults to
 * /var/log/sudo.log if /var/log exists, else /var/adm/sudo.log.
 */
#ifndef _PATH_SUDO_LOGFILE
#define _PATH_SUDO_LOGFILE "/var/log/sudo.log"
#endif /* _PATH_SUDO_LOGFILE */

#ifndef _PATH_SUDO_SENDMAIL
#define _PATH_SUDO_SENDMAIL "/usr/sbin/sendmail"
#endif /* _PATH_SUDO_SENDMAIL */

#ifndef _PATH_VI
#define _PATH_VI "/usr/bin/vi"
#endif /* _PATH_VI */

#ifndef _PATH_MV
#define _PATH_MV "/bin/mv"
#endif /* _PATH_MV */

#ifndef _PATH_BSHELL
#define _PATH_BSHELL "/bin/sh"
#endif /* _PATH_BSHELL */
