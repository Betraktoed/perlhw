package DeepClone;
# vim: noet:

use 5.016;
no warnings;

=encoding UTF8

=head1 SYNOPSIS

Клонирование сложных структур данных

=head1 clone($orig)

Функция принимает на вход ссылку на какую либо структуру данных и отдает, в качестве результата, ее точную независимую копию.
Это значит, что ни один элемент результирующей структуры, не может ссылаться на элементы исходной, но при этом она должна в точности повторять ее схему.

Входные данные:
* undef
* строка
* число
* ссылка на массив
* ссылка на хеш
Элементами ссылок на массив и хеш, могут быть любые из указанных выше конструкций.
Любые отличные от указанных типы данных -- недопустимы. В этом случае результатом клонирования должен быть undef.

Выходные данные:
* undef
* строка
* число
* ссылка на массив
* ссылка на хеш
Элементами ссылок на массив или хеш, не могут быть ссылки на массивы и хеши исходной структуры данных.

=cut

sub clone {
	my $orig = shift;
	my $cloned;
	# статические переменная и массив, первая -  проверки на соответствие входных параметров, второй - для
	# записи ссылок и проверки отсутствия рекурсии
	state $check = 1; 
	state @mas;
	
	for (@mas) {
		$check = 0 if ( $orig eq $_ );	
	}
	
	push @mas, $orig if ( ref $orig eq 'HASH' || ref $orig eq 'ARRAY' ) ; 
	if ($check){
		given(ref $orig){
			when ( 'HASH' ) {
				$cloned = {};
				while ( my ($key, $value) = each (%$orig) ) {
					$cloned -> {$key} = clone ($value);
				}
			}
			when ( 'ARRAY' ) {
				$cloned = [];
				@$cloned = map { clone($_) } @$orig;
			}
			when ( '' ) {
				if ( not defined $orig ){
					return undef;
				}
				else{
					return $orig;
				}
			}
			default	{ $check=0;return undef;}
		}
	}

	
	return $cloned if $check;
	return undef;
}

1;
