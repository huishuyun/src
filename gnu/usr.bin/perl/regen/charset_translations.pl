#!/usr/bin/perl -w
use strict;
use warnings;

# WARNING: This must be kept in sync with the UTF8_MAXBYTES value in
# utfebcdic.h
$CHARSET_TRANSLATIONS::UTF_EBCDIC_MAXBYTES = 14;

# Utilities for various character set issues.  Currently handles ASCII and
# EBCDIC only.  It is trivial to add support for new EBCDIC code pages (unless
# they have identical variant character signatures as existing ones, and there
# aren't other glitches that arise): just add a mapping table to
# %ebcdic_translations and regen everything that uses this.

my %ebcdic_translations = (
    # Keys are code page name; values are arrays that map ASCII ordinals to
    # the code page's ordinals

    'EBCDIC 1047' =>
      [ 0x00, 0x01, 0x02, 0x03, 0x37, 0x2D, 0x2E, 0x2F, 0x16, 0x05, 0x15, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
        0x10, 0x11, 0x12, 0x13, 0x3C, 0x3D, 0x32, 0x26, 0x18, 0x19, 0x3F, 0x27, 0x1C, 0x1D, 0x1E, 0x1F,
        0x40, 0x5A, 0x7F, 0x7B, 0x5B, 0x6C, 0x50, 0x7D, 0x4D, 0x5D, 0x5C, 0x4E, 0x6B, 0x60, 0x4B, 0x61,
        0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0x7A, 0x5E, 0x4C, 0x7E, 0x6E, 0x6F,
        0x7C, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6,
        0xD7, 0xD8, 0xD9, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xAD, 0xE0, 0xBD, 0x5F, 0x6D,
        0x79, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96,
        0x97, 0x98, 0x99, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xC0, 0x4F, 0xD0, 0xA1, 0x07,
        0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x06, 0x17, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x09, 0x0A, 0x1B,
        0x30, 0x31, 0x1A, 0x33, 0x34, 0x35, 0x36, 0x08, 0x38, 0x39, 0x3A, 0x3B, 0x04, 0x14, 0x3E, 0xFF,
        0x41, 0xAA, 0x4A, 0xB1, 0x9F, 0xB2, 0x6A, 0xB5, 0xBB, 0xB4, 0x9A, 0x8A, 0xB0, 0xCA, 0xAF, 0xBC,
        0x90, 0x8F, 0xEA, 0xFA, 0xBE, 0xA0, 0xB6, 0xB3, 0x9D, 0xDA, 0x9B, 0x8B, 0xB7, 0xB8, 0xB9, 0xAB,
        0x64, 0x65, 0x62, 0x66, 0x63, 0x67, 0x9E, 0x68, 0x74, 0x71, 0x72, 0x73, 0x78, 0x75, 0x76, 0x77,
        0xAC, 0x69, 0xED, 0xEE, 0xEB, 0xEF, 0xEC, 0xBF, 0x80, 0xFD, 0xFE, 0xFB, 0xFC, 0xBA, 0xAE, 0x59,
        0x44, 0x45, 0x42, 0x46, 0x43, 0x47, 0x9C, 0x48, 0x54, 0x51, 0x52, 0x53, 0x58, 0x55, 0x56, 0x57,
        0x8C, 0x49, 0xCD, 0xCE, 0xCB, 0xCF, 0xCC, 0xE1, 0x70, 0xDD, 0xDE, 0xDB, 0xDC, 0x8D, 0x8E, 0xDF
      ],

#    'EBCDIC POSIX-BC' =>
#      [
#        0x00, 0x01, 0x02, 0x03, 0x37, 0x2D, 0x2E, 0x2F, 0x16, 0x05, 0x15, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
#        0x10, 0x11, 0x12, 0x13, 0x3C, 0x3D, 0x32, 0x26, 0x18, 0x19, 0x3F, 0x27, 0x1C, 0x1D, 0x1E, 0x1F,
#        0x40, 0x5A, 0x7F, 0x7B, 0x5B, 0x6C, 0x50, 0x7D, 0x4D, 0x5D, 0x5C, 0x4E, 0x6B, 0x60, 0x4B, 0x61,
#        0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0x7A, 0x5E, 0x4C, 0x7E, 0x6E, 0x6F,
#        0x7C, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6,
#        0xD7, 0xD8, 0xD9, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xBB, 0xBC, 0xBD, 0x6A, 0x6D,
#        0x4A, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96,
#        0x97, 0x98, 0x99, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xFB, 0x4F, 0xFD, 0xFF, 0x07,
#        0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x06, 0x17, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x09, 0x0A, 0x1B,
#        0x30, 0x31, 0x1A, 0x33, 0x34, 0x35, 0x36, 0x08, 0x38, 0x39, 0x3A, 0x3B, 0x04, 0x14, 0x3E, 0x5F,
#        0x41, 0xAA, 0xB0, 0xB1, 0x9F, 0xB2, 0xD0, 0xB5, 0x79, 0xB4, 0x9A, 0x8A, 0xBA, 0xCA, 0xAF, 0xA1,
#        0x90, 0x8F, 0xEA, 0xFA, 0xBE, 0xA0, 0xB6, 0xB3, 0x9D, 0xDA, 0x9B, 0x8B, 0xB7, 0xB8, 0xB9, 0xAB,
#        0x64, 0x65, 0x62, 0x66, 0x63, 0x67, 0x9E, 0x68, 0x74, 0x71, 0x72, 0x73, 0x78, 0x75, 0x76, 0x77,
#        0xAC, 0x69, 0xED, 0xEE, 0xEB, 0xEF, 0xEC, 0xBF, 0x80, 0xE0, 0xFE, 0xDD, 0xFC, 0xAD, 0xAE, 0x59,
#        0x44, 0x45, 0x42, 0x46, 0x43, 0x47, 0x9C, 0x48, 0x54, 0x51, 0x52, 0x53, 0x58, 0x55, 0x56, 0x57,
#        0x8C, 0x49, 0xCD, 0xCE, 0xCB, 0xCF, 0xCC, 0xE1, 0x70, 0xC0, 0xDE, 0xDB, 0xDC, 0x8D, 0x8E, 0xDF
#      ],

    'EBCDIC 037' =>
      [
        0x00, 0x01, 0x02, 0x03, 0x37, 0x2D, 0x2E, 0x2F, 0x16, 0x05, 0x25, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
        0x10, 0x11, 0x12, 0x13, 0x3C, 0x3D, 0x32, 0x26, 0x18, 0x19, 0x3F, 0x27, 0x1C, 0x1D, 0x1E, 0x1F,
        0x40, 0x5A, 0x7F, 0x7B, 0x5B, 0x6C, 0x50, 0x7D, 0x4D, 0x5D, 0x5C, 0x4E, 0x6B, 0x60, 0x4B, 0x61,
        0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0x7A, 0x5E, 0x4C, 0x7E, 0x6E, 0x6F,
        0x7C, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6,
        0xD7, 0xD8, 0xD9, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xBA, 0xE0, 0xBB, 0xB0, 0x6D,
        0x79, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96,
        0x97, 0x98, 0x99, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xC0, 0x4F, 0xD0, 0xA1, 0x07,
        0x20, 0x21, 0x22, 0x23, 0x24, 0x15, 0x06, 0x17, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x09, 0x0A, 0x1B,
        0x30, 0x31, 0x1A, 0x33, 0x34, 0x35, 0x36, 0x08, 0x38, 0x39, 0x3A, 0x3B, 0x04, 0x14, 0x3E, 0xFF,
        0x41, 0xAA, 0x4A, 0xB1, 0x9F, 0xB2, 0x6A, 0xB5, 0xBD, 0xB4, 0x9A, 0x8A, 0x5F, 0xCA, 0xAF, 0xBC,
        0x90, 0x8F, 0xEA, 0xFA, 0xBE, 0xA0, 0xB6, 0xB3, 0x9D, 0xDA, 0x9B, 0x8B, 0xB7, 0xB8, 0xB9, 0xAB,
        0x64, 0x65, 0x62, 0x66, 0x63, 0x67, 0x9E, 0x68, 0x74, 0x71, 0x72, 0x73, 0x78, 0x75, 0x76, 0x77,
        0xAC, 0x69, 0xED, 0xEE, 0xEB, 0xEF, 0xEC, 0xBF, 0x80, 0xFD, 0xFE, 0xFB, 0xFC, 0xAD, 0xAE, 0x59,
        0x44, 0x45, 0x42, 0x46, 0x43, 0x47, 0x9C, 0x48, 0x54, 0x51, 0x52, 0x53, 0x58, 0x55, 0x56, 0x57,
        0x8C, 0x49, 0xCD, 0xCE, 0xCB, 0xCF, 0xCC, 0xE1, 0x70, 0xDD, 0xDE, 0xDB, 0xDC, 0x8D, 0x8E, 0xDF
      ],
);

my $ascii_key = 'ASCII/Latin1';

my %I8_TO_NATIVE_UTF8;  # Maps I8 UTF to final UTF-EBCDIC
                        # See http://www.unicode.org/reports/tr16/

sub get_supported_code_pages() {
    # Returns an ordered array of the currently supported code pages,
    # including ASCII as the 0th element, 1047 as the 1th, and the others
    # sorted lexically by code page name.

    # Create an ASCII table.
    unless (exists $ebcdic_translations{$ascii_key}) {
        for my $i (0 .. 255) {
            $ebcdic_translations{$ascii_key}->[$i] = $i;
        }
    }

    return sort {
                  $a eq $ascii_key
                  ? -1
                  : $b eq $ascii_key
                    ? 1
                    : $a =~ /1047/
                      ? -1
                      : $b =~ /1047/
                        ? 1
                        : $a cmp $b
                } keys %ebcdic_translations;
}

sub get_a2n($) {
    # Returns the mapping array for ASCII to code page for the code page named
    # by the input parameter.

    my $charset = shift;

    if (! exists $ebcdic_translations{$charset}) {
        die "Unknown character set '$charset'";
    }

    return $ebcdic_translations{$charset};
}

sub get_I8_2_utf($) {
    # Returns the mapping array for I8 to code page UTF-EBCDIC for the code
    # page named by the input parameter.  This is Table 2 of TR16 customized
    # for the code page.  See utfebcdic.h for why, contrary to TR16, it has to
    # be code-page-specific.

    my $charset = shift;

    die "I8 not a valid concept for ASCII" if $charset eq $ascii_key;
    die "'$charset' unknown" unless exists $ebcdic_translations{$charset};

    # Generate the table if not already present
    if (! exists $I8_TO_NATIVE_UTF8{$charset}) {

        # The code points not used for invariants.  Initialized to everything,
        # then entries are removed as we go along.
        my %unused_cps;
        for my $i (0 .. 255) {
            $unused_cps{$i} = 1;
        }

        # These are the invariants.  The output has them mapped to the
        # original EBCDIC code point.
        for my $i (0 .. 0x9F) {
            use charnames ();
            my $ebcdic_value = $ebcdic_translations{$charset}[$i];
            #printf "$charset: using %02x which is %02x ascii, %s\n", $ebcdic_value, $i, charnames::viacode($i);
            $I8_TO_NATIVE_UTF8{$charset}[$i] = $ebcdic_value;
            if (! defined delete $unused_cps{$ebcdic_value}) {
                die "Two code points map to $ebcdic_value; one is $i";
            }
        }

        # Put the unused code points in order
        my @unused_cps = sort { $a <=> $b } keys %unused_cps;

        # Fill in the rest of the map with these ordered code points, as TR16
        # specifies
        for my $i (0xA0 .. 255) {
            $I8_TO_NATIVE_UTF8{$charset}[$i] = shift @unused_cps;
            #printf "$charset: filling in %02x which is %02x ascii, %s\n", $I8_TO_NATIVE_UTF8{$charset}[$i], $i, charnames::viacode($i);
        }

        if (@unused_cps) {
            die "Left-over code points";
        }
    }

    return $I8_TO_NATIVE_UTF8{$charset};
}

{ # Closure

    my $charset;    # We use these to do some error checking that the #if and
                    # #endif are matched.
    my $indent;

    sub get_conditional_compile_line_start($;$) {
        # Returns the '#if' line to put into C code to compile for the code
        # page given by the first parameter.  The second parameter, if
        # present, is the indentation level, like '#   if ...'

        if (defined $charset || defined $indent) {
            die "Missing call to get_conditional_compile_line_end()"
        }

        $charset = shift;
        my $indent_level = shift // 0;

        die "This is designed to run only on an ASCII platform" unless ord "A" == 65;

        if ($indent_level == 0) {
            $indent = "";
        }
        else {
            $indent = " " x (($indent_level * 4) - 1);
        }

        die "Unknown character set '$charset'" unless exists $ebcdic_translations{$charset};

        my $return = "";
        {
            no warnings 'qw';
            my $count = -1;

            # We use all the typical variant characters to construct the #if,
            # so that it is unlikely that a different code page will match
            # this #if
            for my $char (qw/A \\\ [ ] { } ^ ~ ! # | $ @ `/) {
                my $compare;
                my $ascii_ord = ord $char;
                my $first_time = $return eq "";

                $compare = $ebcdic_translations{$charset}[$ascii_ord];
                $return .=  " && " unless $first_time;
                $return .= "'$char' == $compare";
                $return .= " /* $charset */" if $first_time;
                last if $charset eq $ascii_key;
                $count++;
                $return .= " \\\n    " if $first_time || $count % 5 == 0;
            }
        }

        return "#${indent}if $return\n";
    }

    sub get_conditional_compile_line_end () {
        # Returns the #endif for the currently open #if

        my $return = "#${indent}endif\t/* $charset */\n";
        undef $charset;
        undef $indent;
        return $return;
    }
}

sub _UTF_START_MASK($) {
    # Internal
    my $len = shift;
    return (($len >= 7) ? 0x00 : (0x1F >> ($len - 2)));
}

sub _UTF_START_MARK($) {
    # Internal
    my $len = shift;
    return (($len >  7) ? 0xFF : (0xFF & (0xFE << (7- $len))));
}

sub cp_2_utfbytes($$) {
    # Returns a string consisting of the UTF-EBCDIC for the code page given by
    # the 2nd parameter, of the Unicode code point given by the first
    # parameter, using the UTF-MOD algorithm published in TR16.  (If the "code
    # page" is ASCII, straight UTF-8 is returned.)

    my ($ucp, $charset) = @_;

    if ($charset eq $ascii_key) {
        my $str = chr $ucp;
        utf8::upgrade($str);
        utf8::encode($str);
        return $str;
    }
    elsif (exists $ebcdic_translations{$charset}) {

        if ($ucp < 0xA0) {
            return chr $ebcdic_translations{$charset}[$ucp];
        }

        my $I8_2_utf = get_I8_2_utf($charset);

        my $len = $ucp < 0xA0      ? 1 :
		  $ucp < 0x400     ? 2 :
		  $ucp < 0x4000    ? 3 :
		  $ucp < 0x40000   ? 4 :
		  $ucp < 0x400000  ? 5 :
		  $ucp < 0x4000000 ? 6 :
		  $ucp < 0x40000000? 7 :
                                    $CHARSET_TRANSLATIONS::UTF_EBCDIC_MAXBYTES;

        my @str;
	for (1 .. $len - 1) {
            unshift @str, chr $I8_2_utf->[($ucp & 0x1f) | 0xA0];
	    $ucp >>= 5;
	}

	unshift @str, chr $I8_2_utf->[($ucp & _UTF_START_MASK($len)) | _UTF_START_MARK($len)];

        return join "", @str;
    }
    else {
        die "Unknown character set '$charset'";
    }
}

1;
