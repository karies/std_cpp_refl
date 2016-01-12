
/*
 *  Copyright 2015 Matus Chochlik.
 */

//[meta_get_elaborated_type_specifier
__namespace_meta_begin

template <typename T>
__requires __MetaClass<T>
struct get_elaborated_type_specifier
{

	typedef __MetaSpecifier type; /*<
	returns a MetaSpecifier reflecting the elaborated type specifier (class,struct,union,...) of a class reflected by a MetaClass.
	>*/
};

template <typename T>
using get_elaborated_type_specifier_t = typename get_elaborated_type_specifier<T>::type;

__namespace_meta_end
//]
