<#include "security.ftlh">
<#import "login.ftlh" as l>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <#if user?? && name!="unknown">
            <div class="d-flex ms-auto me-3">>
                <div class="navbar-text me-3">${name}</div>
                <@l.logout />
            </div>
        <#else>
            <div class="mt-0 ms-5 bg-dark">
                <div class="media d-flex align-items-center">
                    <img src="/img/logo.png" alt="..." width="45" class="mr-3 rounded-circle "/>
                    <div class="media-body">
                        <a class="fw-bold text-light fs-4 nav-link" href="/">Fate</a>
                    </div>
                </div>
            </div>

            <form action="/login" class="ms-auto me-3">
                <button class="btn btn-secondary " type="submit">Вход</button>
            </form>
            <form action="/registration">
                <button class="btn btn-secondary" type="submit">Регистрация</button>
            </form>`
        </#if>
    </div>
</nav>

<#if user?? && name!="unknown">
    <div class="vertical-nav bg-dark" id="sidebar">
        <div class="mt-1 ms-5 mb-4 bg-dark">
            <div class="media d-flex align-items-center ">
                <img src="/img/logo.png" alt="..." width="45" class="mr-3 rounded-circle "/>
                <div class="media-body">
                    <a class="fw-bold text-light fs-4 nav-link" href="/">Fate</a>
                </div>
            </div>
        </div>

        <ul class="nav flex-column bg-dark mt-4 ms-3 fs-5">
            <li class="nav-item mt-4">
                <a href="/user/${currentUserID}/profile" class="nav-link bg-dark text-secondary fw-bold">
                    Профиль
                </a>
            </li>
            <li class="nav-item">
                <a href="/user/subscriptions/${currentUserID}" class="nav-link bg-dark text-secondary fw-bold">
                    Подписки
                </a>
            </li>
            <li class="nav-item">
                <a href="/orders/${currentUserID}/customer" class="nav-link bg-dark text-secondary fw-bold">
                    Заказы
                </a>
            </li>

            <#if user.isArtist()>
            <li class="nav-item">
                <a href="/orders/${currentUserID}/artist" class="nav-link bg-dark text-secondary fw-bold">
                    Работы
                </a>
            </li>
            </#if>

            <li class="nav-item">
                <a href="/settings/${currentUserID}" class="nav-link bg-dark text-secondary fw-bold">
                    Настройки
                </a>
            </li>
            <li class="nav-item">
                <a href="/search/" class="nav-link bg-dark text-secondary fw-bold">
                    Поиск
                </a>
            </li>
        </ul>
        <div class="text-secondary ms-4 fixed-bottom">Чаус Екатерина, 2021</div>>
    </div>
</#if>

