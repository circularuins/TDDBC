use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;

use_ok 'Javersion';

subtest 'validであるか' => sub {
    my $class = Javersion->new();
    is $class->is_valid(), 0, "引数がない場合は0を返すこと";
    is $class->is_valid('JDK7u40'), 1, "JDK7u40を渡すと1を返すこと";
    is $class->is_valid('hoge'), 0, 'hogeを渡すと0を返すこと';
    is $class->is_valid('JDK7u41'), 1, "JDK7u41を渡すと1を返すこと";
    is $class->is_valid('JDK7u40a'), 0, "JDK7u40aを渡すと0を返すこと";
    is $class->is_valid('JDK07u40'), 0, "JDK07u40を渡すと0を返すこと";
    is $class->is_valid('JDK7u040'), 0, "JDK7u040を渡すと0を返すこと";
};

subtest 'バージョン番号を取得できるか' => sub {
    my $class1 = Javersion->new('JDK7u40');
    my $class2 = Javersion->new('JDK8u50');
    my $class3 = Javersion->new('hoge');
    subtest 'family numberを取得できるか' => sub {
        is $class1->get_family_number(), 7, "JDK7u41をパースしてfamily_numberの7を返すこと";
        is $class2->get_family_number(), 8, "JDK8u50をパースしてfamily_numberの8を返すこと";
    };
    subtest 'update numberを取得できるか' => sub {
        is $class1->get_update_number(), 40, "JDK7u40をパースしてupdate_numberの40を返すこと";
        is $class2->get_update_number(), 50, "JDK8u50をパースしてupdate_numberの50を返すこと";
    };
    subtest '不正な文字列を渡すと例外を返すか' => sub {
        throws_ok { $class3->get_family_number() } qr/error!/, "例外をキャッチすること";
        throws_ok { $class3->get_update_number() } qr/error!/, "例外をキャッチすること";
    };
};

done_testing;
