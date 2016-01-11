
/*
 *  Copyright 2015 Matus Chochlik.
 */

//[reflexpr_MetaScope_def

template <typename T>
__concept bool MetaScope = __MetaNamed<T> && __meta::__is_scope_v<T>;

//]
//[reflexpr_MetaScope_begin
__namespace_meta_begin
//]
//[reflexpr_MetaScope_inherited_traits

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

//]
//[reflexpr_MetaScope_traits

template <>
struct __is_scope<MetaScope>
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

//]
//[reflexpr_MetaScope_inherited_operations

template <>
struct __source_file<MetaScope>
{
	
	typedef const char value_type[N+1];

	static constexpr const char value[N+1] = ... /*<
	Source file path of the declaration of a scope reflected by a MetaScope.
	>*/;

	typedef __StringConstant type;

	operator const char* (void) const noexcept;
	const char* operator (void) const noexcept;
	
};

template <>
struct __source_line<MetaScope>
{
	
	typedef unsigned value_type;
	static constexpr const unsigned value = ... /*<
	Source file line of the declaration of a scope reflected by a MetaScope.
	>*/;

	typedef __integral_constant<value_type, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
	
};

template <>
struct __source_column<MetaScope>
{
	
	typedef unsigned value_type;
	static constexpr const unsigned value = ... /*<
	Source file column of the declaration of a scope reflected by a MetaScope.
	>*/;

	typedef __integral_constant<value_type, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
	
};

template <>
struct __get_name<MetaScope>
{
	
	typedef const char value_type[N+1];

	static constexpr const char value[N+1] = ... /*<
	The basic name of the a scope reflected by a MetaScope.
	>*/;

	typedef __StringConstant type;

	operator const char* (void) const noexcept;
	const char* operator (void) const noexcept;
	
};

template <>
struct __get_scope<MetaScope>
{
	
	typedef __MetaScope type; /*<
	The MetaScope reflecting the scope of a scope reflected by a MetaScope.
	>*/
	
};

//]
//[reflexpr_MetaScope_operations

//]
//[reflexpr_MetaScope_end
__namespace_meta_end
//]
