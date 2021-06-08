<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>

<div class="container d-flex">
    <form method="post" action = "${userChannel.getId()}/avatar" enctype="multipart/form-data" class="col-3 me-0">
        <label for="image" class="col-15">
            <input type="file" name = "image"  id="image" style="display:none;" onchange="form.submit()">
            <img src="/img/avatars/${userChannel.getAvatar()}" class="rounded-circle col-10" alt="Аватар"/>
        </label>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
    <div >
        <div class="mt-5">
            <h1 class="text-light">${userChannel.username}</h1>
        </div>
        <div>
            <h5>
                <form method="post" action = "${userChannel.getId()}/artist">

                <div class="form-check">
                    <input class="form-check-input me-2 bg-secondary text-light"
                           type="checkbox" name="isArtist" id="isArtist"
                           onchange="form.submit()"
                            <#if userChannel.isArtist()>
                                checked
                            </#if>
                    >
                    <label class="form-check-label text-light" for="isArtist">
                        Художник
                    </label>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        </form>
            </h5>
        </div>
    </div>
</div>


<div class ="container">
    <h5 class="text-light mt-4">Сайты</h5>
    <#if user.getSites()??>
    <#list user.getSites() as site>
        <form action = "${userChannel.getId()}/site/delete" method="post">
            <div class="input-group mb-1">
                <input type="hidden" name="siteId" value="${site.getId()}">
                <input type="text" class="form-control border-secondary bg-dark text-light col-2" value="${site.getSiteName()}">
                <input type="text" class="form-control border-secondary bg-dark text-light" value="${site.getSiteAddress()}">
                <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-x-square fs-5 text-danger"></i></button>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        </form>
    </#list>
    </#if>
<form action = "${userChannel.getId()}/site/add" method="post">
    <div class="input-group mt-3" >
        <input type="text" class="form-control border-secondary bg-dark text-light col-2" placeholder="Имя сайта" name="siteName">
        <input type="text" class="form-control border-secondary bg-dark text-light" placeholder="ссылка" name="siteLink">
        <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-plus-square fs-5 text-success"></i></button>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>
</div>

<form action = "${userChannel.getId()}/edit" method="post">
<div class="container">
    <h5 class="text-light mt-4">Информация</h5>
    <div class="input-group mt-3">
        <textarea class="form-control border-secondary bg-dark text-light" name="userInfo"><#if user.getUserInfo()??>${user.getUserInfo()}</#if></textarea>
    </div>
</div>
<div class = "container">
    <h5 class="text-light mt-4">Смена пароля</h5>
    <div class="input-group mb-1">
            <span class="input-group-text border-secondary col-2 bg-dark text-light">
                Новый пароль
            </span>
        <input type="password"
               class="form-control border-secondary col-md-2 bg-dark text-light"
               name="password"
        />
    </div>
    <div class="input-group mb-3">
            <span class="input-group-text border-secondary col-2 bg-dark text-light">
                Повторите пароль
            </span>
        <input type="password"
               class="form-control ${(password2Error??)?string('is-invalid','')} border-secondary col-md-2 bg-dark text-light"
               name="password2"
        />
    </div>
    <div class="input-group  mt-3 mb-3">
            <span class="input-group-text border-secondary col-2 bg-dark text-light">
                Текущий пароль
            </span>
        <input type="password"
               class="form-control ${(currentPasswordError??)?string('is-invalid','')} border-secondary col-md-2 bg-dark text-light"
               name="currentPassword"
        />
    </div>
</div>

<div class="d-flex flex-row-reverse">
    <button type="submit" class="btn btn-secondary ms-auto me-3" type="button">Редактировать профиль</button>
</div>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>
</@c.page>