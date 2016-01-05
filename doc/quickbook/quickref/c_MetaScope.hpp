
/*
 *  Copyright 2015 Matus Chochlik.
 */

//[reflexpr_MetaScope
__namespace_meta_begin


template <>
struct __has_name<MetaScope> /*<
Inherited from __MetaNamed.
>*/
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

template <>
struct __has_scope<MetaScope> /*<
Inherited from __MetaScoped.
>*/
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

template <>
struct __is_scope<MetaScope>
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

template <>
struct source_file<MetaScope>
{
	
	typedef const char value_type[N+1];

	static constexpr const char value[N+1] = ... /*<
	Source file path of the declaration of a scope reflected by this MetaScope.
	>*/;

	typedef __StringConstant type;

	operator const char* (void) const noexcept;
	const char* operator (void) const noexcept;
	
};

template <>
struct source_line<MetaScope>
{
	
	typedef unsigned value_type;
	static constexpr const unsigned value = /*<
	Source file line of the declaration of a scope reflected by this MetaScope.
	>*/;

	typedef __integral_constant<value_type, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
	
};

template <>
struct source_column<MetaScope>
{
	
	typedef unsigned value_type;
	static constexpr const unsigned value = /*<
	Source file column of the declaration of a scope reflected by this MetaScope.
	>*/;

	typedef __integral_constant<value_type, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
	
};

template <>
struct get_name<MetaScope>
{
	
	typedef const char value_type[N+1];

	static constexpr const char value[N+1] = ... /*<
	the basic name
	>*/;

	typedef __StringConstant type;

	operator const char* (void) const noexcept;
	const char* operator (void) const noexcept;
	
};

template <>
struct get_scope<MetaScope>
{
	 typedef __MetaScope type;
};


__namespace_meta_end
//]
