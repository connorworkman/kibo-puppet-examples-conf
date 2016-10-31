hiera_include('classes')
node default {
	include ::apache2
	include ::demo-module
	include ::demo-module::groups::dev
	include ::demo-module::groups::wheel
	include ::ntp
}
