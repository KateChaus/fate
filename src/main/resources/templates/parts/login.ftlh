<#macro login path isRegisterForm>
<div class =  "d-flex justify-content-center">
    <form action="${path}" class="col-5" method="post">
        <div class="input-group  mb-3">
            <span class="input-group-text col-2 bg-dark text-light">
                Логин
            </span>
            <input type="text"
                   class="form-control ${(usernameError??)?string('is-invalid','')} bg-dark text-light"
                   name="username" value="<#if user??>${user.username}</#if>"
            />
            <#if usernameError??>
                <div class = "invalid-feedback col-2">
                    ${usernameError}
                </div>
            </#if>
        </div>
        <div class="input-group mb-3">
            <span class="input-group-text col-2 bg-dark text-light">
                Пароль
            </span>
            <input type="password"
                   class="form-control ${(passwordError??)?string('is-invalid','')} col-md-2 bg-dark text-light"
                   name="password"
            />
            <#if passwordError??>
                <div class = "invalid-feedback">
                    ${passwordError}
                </div>
            </#if>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <#if isRegisterForm>
            <div class="input-group mb-3">
                <span class="input-group-text col-4 bg-dark text-light">
                    Подтвердите пароль
                </span>
                <input type="password"
                       class="form-control ${(password2Error??)?string('is-invalid','')} col-md-2 bg-dark text-light"
                       name="password2"/>
                <#if password2Error??>
                    <div class = "invalid-feedback">
                        ${password2Error}
                    </div>
                </#if>
            </div>
        </#if>

        <div class = "d-flex justify-content-center">
            <button class="btn btn-secondary" type="submit"/>
                <#if isRegisterForm>
                    Регистрация
                <#else>
                    Вход
                </#if>
            </button>

            <#if !isRegisterForm >
                <a class="btn btn-secondary ms-3" href="/registration">Регистрация</a>
            </#if>
        </div>
    </form>
</div>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-secondary" type="submit">Выход</button>
    </form>
</#macro>