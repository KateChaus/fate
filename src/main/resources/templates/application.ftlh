<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>

<form method="post" class="ms-5">
    <div>
        <div class="container-fluid mb-4 ms-2">
            <#if artistSearch="true">
                <h2 class="text-light">${userChannel.getUsername()} - заявка заказчика</h2>
            <#else>
                <h2 class="text-light">${userChannel.getUsername()} - заявка художника</h2>
            </#if>
        </div>
        <input type="hidden" name="artistSearch" value="${artistSearch}">

        <div class="d-flex justify-content-start ms-2 col-5">
            <div class="input-group mb-3">
            <span class="input-group-text bg-dark text-light col-4">
                Название
            </span>
                <input type="text"
                       class="form-control bg-dark text-light"
                       name="name"
                />
            </div>
        </div>

        <div class="d-flex justify-content-start ms-2 col-5">
            <div class="input-group mb-3">
                <span class="input-group-text bg-dark text-light col-4">
                Стоимость
                </span>
                <input type="text"
                       class="form-control bg-dark text-light"
                       name="cost"
                />
            </div>
        </div>

        <div class="d-flex justify-content-start ms-2 col-5">
            <div class="input-group mb-3">
                <span class="input-group-text bg-dark text-light col-4">Стиль</span>
                <select id="type" name="type" class="form-select bg-dark text-light ">
                    <option value="traditional">2D (Традиционный)</option>
                    <option value="digital">2D (Цифровой)</option>
                    <option value="threedimensional">3D</option>
                    <option value="animation">Анимация</option>
                    <option value="other">Другое</option>
                </select>
            </div>
        </div>

        <div class="container p-0 ms-2 col-5">
            <h5 class="text-light">Описание</h5>
            <div class="input-group mt-3">
                <textarea class="form-control border-secondary bg-dark text-light" name="description" rows="5" style="height:100%;"></textarea>
            </div>
        </div>

    </div>
    <div class="d-flex justify-content-start">
        <button type="submit" class="btn btn-secondary ms-2 mt-3" type="button">Создать</button>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>
</@c.page>