#!/usr/bin/perl
use v5.14;
use warnings;
use strict;
use HTML::TokeParser;

# variables definition
my $rofiSay;
my $browser;
my $bookmarks;

# subroutines
sub htmlParcer {
    my %bookmarks;
    my $p = HTML::TokeParser->new($_[0]) || die;
    while ( my $tag = $p->get_tag( 'a' ) ) { 
        $bookmarks{$p->get_text} = $tag->[1]{href};
    }
    return \%bookmarks;
}

sub askRofi {
    my $bookmark = shift;
    my $answer = `echo "@$bookmark" | rofi -dmenu -width 50 -p Bookmarks`;
    $answer =~ s/^(?:\s+)?\d+\s+//g; 
    chomp $answer;
    return $answer;
}

sub ddgSearch {
    $_[0] =~ s/^ddg\s+//gi;
    `"$browser" "https://duckduckgo.com/?q=$_[0]"`;
    exit 0;
}

sub imgSearch {
    $_[0] =~ s/^img\s+//gi;
    `"$browser" "https://duckduckgo.com/?q=${_[0]}&ia=images&iax=1"`;
    exit 0;
}

sub videoSearch {
    $_[0] =~ s/^video\s+//gi;
    `"$browser" "https://duckduckgo.com/?q=${_[0]}&ia=videos&iax=1"`;
    exit 0;
}

sub googleSearch {
    $_[0] =~ s/^goog\s+//gi;
    `"$browser" "https://www.google.ru/search?q=$_[0]"`;
    exit 0;
}

sub wikiSearch {
    $_[0] =~ s/^wiki\s+//gi;
    `"$browser" "https://ru.wikipedia.org/wiki/Special:Search?search=$_[0]"`;
    exit 0;
}

sub makeLinks {
    my @array;
    foreach (sort keys %$bookmarks) {
        state $counter = " 1";
        push (@array, ($counter . " " . $_ . "\n")); 
        $counter++;
    }
    return \@array;
}

sub starDictTranslate {
    $_[0] =~ s/^rus\s+//gi;
    my $translate = `sdcv -n --data-dir ~/dic/eng/ "$_[0]"`;
    if ($translate =~/^Найдено 1 слов, похожих/) {
        $translate = (split(/\n/, $translate))[5]; # взять первую статью.
    }
    elsif ($translate =~ /^Найдено\s\d+\sслов\,\sпохожих/) {
        $translate =~ s/-->English-Russian\s full\s dictionary\n//gx; # убрать ссылки на используемые словари.
        my @tempArr = split("\n", $translate);
        $translate = $tempArr[0] . "\n"; # заголовок - найдено столько то слов.
        foreach (@tempArr) {
            if (/(-->\w)/) { # выбрать все похожие слова.
                $_ =~ s/[^A-z]//g; # отбросить префиксы --> ## TODO: возможно добавить счетчик?
                $translate .= $_ . "\n";
            }
        }
    }
    # либо если нет ни одного совпадения то вывести исходное сообщение 
    $translate =~ s/\'//g;
    $translate = "notify-send -t 0 -a sdcv \"$_[0]\" \'". $translate . "\'"; # собрать строку для команды, кавычки для bash нужны 
    `$translate`;
    exit 0;
}

sub browserCheck {
    my $bCheck = `pgrep -c firefox`;
    if ($bCheck > 0) { $browser = 'firefox' }
    else {
        $bCheck = `pgrep -c palemoon`;
        if ($bCheck > 0) {$browser = 'palemoon' }
        else { $browser = 'firefox'; system ('firefox & > /dev/null'); }
    }
}

$bookmarks = &htmlParcer("$ENV{HOME}/.bookmarks.html");

$rofiSay = &askRofi(&makeLinks);

if ($rofiSay) {
    if ($rofiSay =~ /^ddg\s*/i) { &browserCheck; &ddgSearch ($rofiSay) }
    elsif ($rofiSay =~ /^img\s*/i) { &browserCheck; &imgSearch ($rofiSay) }
    elsif ($rofiSay =~ /^video\s*/i) { &browserCheck; &videoSearch ($rofiSay) }
    elsif ($rofiSay =~ /^goog\s*/i) { &browserCheck; &googleSearch ($rofiSay) }
    elsif ($rofiSay =~ /^wiki\s*/i) { &browserCheck; &wikiSearch ($rofiSay) }
    elsif ($rofiSay =~ /^rus\s*/i) { &starDictTranslate ($rofiSay) }
    else {
        if (defined $bookmarks->{$rofiSay} && $bookmarks->{$rofiSay} =~ /http[^"]*/i) {
            &browserCheck; `"$browser" "$bookmarks->{$rofiSay}"` }
        else { &ddgSearch($rofiSay) }
    }
}
