
/*
 *  Copyright 2015 Matus Chochlik.
 */

//[reflexpr_Namespace_def

template <typename T>
__concept bool Namespace =
	__Named<T> &&
	__Scope<T> &&
	__Scoped<T> &&
	__meta::__is_namespace_v<T>;

//]
//[reflexpr_Namespace_begin
__namespace_meta_begin
//]
//[reflexpr_Namespace_inherited_traits

template <>
struct __has_name<Namespace> /*<
Inherited from __Named.
>*/
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

template <>
struct __is_scope<Namespace> /*<
Inherited from __Scope.
>*/
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

template <>
struct __has_scope<Namespace> /*<
Inherited from __Scoped.
>*/
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

//]
//[reflexpr_Namespace_traits

template <>
struct __is_namespace<Namespace>
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

//]
//[reflexpr_Namespace_inherited_operations

template <>
struct __reflects_same<Namespace, Namespace>
{
	
	typedef bool value_type;
	static constexpr const bool value = ... /*<
	indicates if two metaobjects reflect the same base-level declaration.
	>*/;

	typedef __integral_constant<bool, value> type;

	operator bool (void) const noexcept;
	bool operator(void) const noexcept;
	
};

template <>
struct __get_source_location<Namespace>
{
	
	typedef __SourceLocation value_type; /*<
	returns the source location info of the declaration of a namespace reflected by a Namespace.
	>*/
	
};

template <>
struct __get_name<Namespace>
{
	
	typedef const char value_type[N+1];

	static constexpr const char value[N+1] = ... /*<
	returns the basic name of the a namespace reflected by a Namespace.
	>*/;

	typedef __StringConstant type;

	operator const char*(void) const noexcept;
	const char* operator(void) const noexcept;
	
};

template <>
struct __get_scope<Namespace>
{
	
	typedef __Scope value_type; /*<
	returns the result reflecting the scope of a namespace reflected by a Namespace.
	>*/
	
};

//]
//[reflexpr_Namespace_operations

//]
//[reflexpr_Namespace_end
__namespace_meta_end
//]
