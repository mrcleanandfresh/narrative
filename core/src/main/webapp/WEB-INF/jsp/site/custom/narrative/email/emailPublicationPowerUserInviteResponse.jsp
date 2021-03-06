<%--
  User: brian
  Date: 3/16/19
  Time: 5:40 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" session="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ss" uri="http://www.narrative.org/tags/core" %>
<%@ taglib prefix="h" uri="http://www.narrative.org/tags/handy" %>
<%@ taglib prefix="comp" tagdir="/WEB-INF/tags/components" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/common/page" %>
<%@ taglib prefix="tool" tagdir="/WEB-INF/tags/common/tool" %>
<%@ taglib prefix="s_page" tagdir="/WEB-INF/tags/site/page" %>
<%@ taglib prefix="email" tagdir="/WEB-INF/tags/site/email" %>
<%@ taglib prefix="narrative" tagdir="/WEB-INF/tags/site/custom/narrative" %>
<%@ taglib prefix="n_email" tagdir="/WEB-INF/tags/site/custom/narrative/email" %>
<%@ taglib prefix="e" tagdir="/WEB-INF/tags/common/email/elements" %>

<ss:ref var="task" className="org.narrative.network.customizations.narrative.service.impl.publication.SendPublicationPowerUserInviteResponseEmailTask"/>

<ss:set var="publication" object="${task.publication}" className="org.narrative.network.customizations.narrative.publications.Publication" />

<ss:set var="wordletSuffix" object="${task.accepted ? '.accepted' : ''}" className="java.lang.String" />

<n_email:emailWrapper
        subject="${h:wordlet('jsp.site.custom.narrative.email.emailPublicationPowerUserInviteResponse.subject' += wordletSuffix)}"
        actionText="${h:wordlet('jsp.site.custom.narrative.email.emailPublicationPowerUserInviteResponse.viewPowerUsers')}"
        actionUrl="${publication.displayUrl}">
    <ss:set var="inviteeName">
        <s_page:displayName role="${task.invitee}" />
    </ss:set>
    <ss:set var="publicationLink">
        <e:a href="${publication.displayUrl}">${publication.nameForHtml}</e:a>
    </ss:set>
    <ss:set var="roles">
        <narrative:publicationRolesList roles="${task.roles}" />
    </ss:set>
    ${h:wordlet3Arg('jsp.site.custom.narrative.email.emailPublicationPowerUserInviteResponse.userInviteResponse' += wordletSuffix, inviteeName, roles, publicationLink)}
</n_email:emailWrapper>
