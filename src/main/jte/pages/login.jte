@import org.springframework.security.web.csrf.CsrfToken

@param Boolean error = false
@param String errorMessage = null
@param Boolean logout = false
@param String logoutMessage = null
@param CsrfToken csrf = null

@template.layout.default(
    content = @`
        <div class="min-h-screen flex items-center justify-center">
            <div class="max-w-md w-full space-y-8 p-8 bg-white rounded-lg shadow-md">
                <div>
                    <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
                        Sign in to your account
                    </h2>
                </div>

                @if(error)
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                        <span class="block sm:inline">
                            ${errorMessage != null ? errorMessage : "An error occurred during login"}
                        </span>
                    </div>
                @endif

                @if(logout)
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                        <span class="block sm:inline">
                            ${logoutMessage != null ? logoutMessage : "You have been logged out"}
                        </span>
                    </div>
                @endif

                <!-- Login Form -->
                <form class="mt-8 space-y-6" action="/login" method="post">
                    @if(csrf != null)
                        <input type="hidden" name="${csrf.getParameterName()}" value="${csrf.getToken()}">
                    @endif
                    <div class="rounded-md shadow-sm -space-y-px">
                        <div>
                            <input name="username" type="text" required
                                   class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder"
                                   placeholder="Username"
                            />
                        </div>
                        <div>
                            <input name="password" type="password" required
                                   class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder"
                                   placeholder="Password"
                            />
                        </div>
                    </div>

                    <div>
                        <button type="submit"
                                class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded">
                            Sign in
                        </button>
                    </div>
                </form>

                <!-- Oauth2 Button -->
                <div class="mt-6">
                    <div class="relative">
                        <div class="absolute inset-0 flex items-center">
                            <div class="w-full border-t border-gray-300"></div>
                        </div>
                        <div class="relative flex justify-center text-sm">
                            <span class="px-2 bg-white text-gray-500">Or continue with</span>
                        </div>
                    </div>

                    <div class="mt-6 grid grid-cols-2 gap-3">
                        <a href="/oauth2/authorization/google"
                           class="w-full inline-flex items-center justify-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-gray-600">
                            <img class="h-5 w-5 mr-2" src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google logo"/>
                            <span>Google</span>
                        </a>

                        <a href="/oauth2/authorization/github"
                           class="w-full inline-flex items-center justify-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-gray-600">
                            <svg class="h-5 w-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                                <path fill-rule="evenodd" d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.17 6.839 9.49.5.092.682-.217.682-."/>
                            </svg>
                            <span>Github</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    `,
    csrf = csrf,
)