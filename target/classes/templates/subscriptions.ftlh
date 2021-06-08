<#import "parts/common.ftlh" as c>

<@c.page>

<nav class="navbar border-top border-secondary navbar-dark bg-dark mt-5">
    <div class="container-fluid">
        <div class="mt-0 bg-dark">
            <div class="d-flex align-items-center">
                <a class="text-light fs-5 nav-link" href="/">Подписки</a>
            </div>
        </div>
    </div>
</nav>

<div class="row row-cols-5 mx-5">
<#if subscriptions??>
    <#list subscriptions as subscription>
            <div class="col d-flex justify-content-start align-items-center col-3">
                <a class="text-light text-decoration-none fs-4 my-2 mx-0" href="/user/${subscription.getId()}/profile"><img src="/img/avatars/${subscription.getAvatar()}" class="rounded-circle col-4 me-2" alt="Аватар"/>${subscription.getUsername()}</a>
            </div>
</#list>
</#if>
</div>



<nav class="navbar border-top border-secondary navbar-dark bg-dark mt-5">
    <div class="container-fluid">
        <div class="mt-0 bg-dark">
            <div class="d-flex align-items-center">
                <a class="text-light fs-5 nav-link" href="/">Подписчики</a>
            </div>
        </div>
</nav>

</@c.page>