
import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class ApiAPI {

    /**
     Получение информации о архивных кандидатах
     
     - parameter endDate: (query) Дата конца фильтрации по дате обновления (в формате YYYY-MM-DD). (optional)
     - parameter startDate: (query) Дата начала фильтрации по дате обновления (в формате YYYY-MM-DD). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminArchiveList(endDate: Date? = nil, startDate: Date? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [ArchiveCandidate]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminArchiveListWithRequestBuilder(endDate: endDate, startDate: startDate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение информации о архивных кандидатах
     - GET /api/admin/archive/
     - Возвращает список архивированных кандидатов. Кандидаты фильтруются по датам обновления в зависимости от параметров запроса 'start_date' и 'end_date'.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter endDate: (query) Дата конца фильтрации по дате обновления (в формате YYYY-MM-DD). (optional)
     - parameter startDate: (query) Дата начала фильтрации по дате обновления (в формате YYYY-MM-DD). (optional)
     - returns: RequestBuilder<[ArchiveCandidate]>
     */
    open class func apiAdminArchiveListWithRequestBuilder(endDate: Date? = nil, startDate: Date? = nil) -> RequestBuilder<[ArchiveCandidate]> {
        let localVariablePath = "/api/admin/archive/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "end_date": (wrappedValue: endDate?.encodeToJSON(), isExplode: true),
            "start_date": (wrappedValue: startDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[ArchiveCandidate]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Восстановление архивированных кандидатов
     
     - parameter candidateIds: (query) Строка с ID кандидатов, разделённая запятой. Например: &#39;1, 2, 3&#39;.
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminArchiveRestoreCreate(candidateIds: String, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: AnyCodable?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminArchiveRestoreCreateWithRequestBuilder(candidateIds: candidateIds).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Восстановление архивированных кандидатов
     - POST /api/admin/archive/restore/
     - Позволяет восстановить кандидатов из архива. Требуется передать список ID кандидатов, разделённых запятой, в теле запроса. Если ID кандидатов некорректны, будет возвращена ошибка.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter candidateIds: (query) Строка с ID кандидатов, разделённая запятой. Например: &#39;1, 2, 3&#39;.
     - returns: RequestBuilder<AnyCodable>
     */
    open class func apiAdminArchiveRestoreCreateWithRequestBuilder(candidateIds: String) -> RequestBuilder<AnyCodable> {
        let localVariablePath = "/api/admin/archive/restore/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "candidate_ids": (wrappedValue: candidateIds.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AnyCodable>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список кандидатов
     
     - parameter candidate: (body)
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminCandidatesCreate(candidate: Candidate, isFree: String? = nil, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Candidate]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminCandidatesCreateWithRequestBuilder(candidate: candidate, isFree: isFree, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список кандидатов
     - POST /api/admin/candidates/
     - Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter candidate: (body)
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - returns: RequestBuilder<[Candidate]>
     */
    open class func apiAdminCandidatesCreateWithRequestBuilder(candidate: Candidate, isFree: String? = nil, search: String? = nil) -> RequestBuilder<[Candidate]> {
        let localVariablePath = "/api/admin/candidates/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: candidate)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "is_free": (wrappedValue: isFree?.encodeToJSON(), isExplode: true),
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Candidate]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список кандидатов
     
     - parameter id: (path) A unique integer value identifying this Кандидат.
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminCandidatesDestroy(id: Int, isFree: String? = nil, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Candidate]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminCandidatesDestroyWithRequestBuilder(id: id, isFree: isFree, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список кандидатов
     - DELETE /api/admin/candidates/{id}/
     - Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Кандидат.
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - returns: RequestBuilder<[Candidate]>
     */
    open class func apiAdminCandidatesDestroyWithRequestBuilder(id: Int, isFree: String? = nil, search: String? = nil) -> RequestBuilder<[Candidate]> {
        var localVariablePath = "/api/admin/candidates/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "is_free": (wrappedValue: isFree?.encodeToJSON(), isExplode: true),
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Candidate]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Обновление статуса приглашения
     
     - parameter candidateId: (path) Идентификатор кандидата
     - parameter invitationId: (path) Идентификатор приглашения
     - parameter body: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminCandidatesInvitationsPartialUpdate(candidateId: Int, invitationId: Int, body: AnyCodable? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: AnyCodable?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminCandidatesInvitationsPartialUpdateWithRequestBuilder(candidateId: candidateId, invitationId: invitationId, body: body).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Обновление статуса приглашения
     - PATCH /api/admin/candidates/{candidate_id}/invitations/{invitation_id}/
     - Позволяет обновить статус конкретного приглашения кандидата.  Поддерживаемые статусы: 'accepted', 'invited', 'rejected', 'self_rejected'.в случае, если передан accepted все остальные приглашения кандидата будут отклонены
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter candidateId: (path) Идентификатор кандидата
     - parameter invitationId: (path) Идентификатор приглашения
     - parameter body: (body)  (optional)
     - returns: RequestBuilder<AnyCodable>
     */
    open class func apiAdminCandidatesInvitationsPartialUpdateWithRequestBuilder(candidateId: Int, invitationId: Int, body: AnyCodable? = nil) -> RequestBuilder<AnyCodable> {
        var localVariablePath = "/api/admin/candidates/{candidate_id}/invitations/{invitation_id}/"
        let candidateIdPreEscape = "\(APIHelper.mapValueToPathItem(candidateId))"
        let candidateIdPostEscape = candidateIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{candidate_id}", with: candidateIdPostEscape, options: .literal, range: nil)
        let invitationIdPreEscape = "\(APIHelper.mapValueToPathItem(invitationId))"
        let invitationIdPostEscape = invitationIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{invitation_id}", with: invitationIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AnyCodable>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение приглашений кандидата
     
     - parameter id: (path) Идентификатор кандидата
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminCandidatesInvitationsRetrieve(id: Int, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [AdminInvitation]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminCandidatesInvitationsRetrieveWithRequestBuilder(id: id).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение приглашений кандидата
     - GET /api/admin/candidates/{id}/invitations/
     - Возвращает список приглашений, связанных с указанным кандидатом. Требует идентификатор кандидата в URL.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) Идентификатор кандидата
     - returns: RequestBuilder<[AdminInvitation]>
     */
    open class func apiAdminCandidatesInvitationsRetrieveWithRequestBuilder(id: Int) -> RequestBuilder<[AdminInvitation]> {
        var localVariablePath = "/api/admin/candidates/{id}/invitations/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[AdminInvitation]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список кандидатов
     
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminCandidatesList(isFree: String? = nil, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Candidate]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminCandidatesListWithRequestBuilder(isFree: isFree, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список кандидатов
     - GET /api/admin/candidates/
     - Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - returns: RequestBuilder<[Candidate]>
     */
    open class func apiAdminCandidatesListWithRequestBuilder(isFree: String? = nil, search: String? = nil) -> RequestBuilder<[Candidate]> {
        let localVariablePath = "/api/admin/candidates/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "is_free": (wrappedValue: isFree?.encodeToJSON(), isExplode: true),
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Candidate]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список кандидатов
     
     - parameter id: (path) A unique integer value identifying this Кандидат.
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminCandidatesList2(id: Int, isFree: String? = nil, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Candidate]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminCandidatesList2WithRequestBuilder(id: id, isFree: isFree, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список кандидатов
     - GET /api/admin/candidates/{id}/
     - Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Кандидат.
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - returns: RequestBuilder<[Candidate]>
     */
    open class func apiAdminCandidatesList2WithRequestBuilder(id: Int, isFree: String? = nil, search: String? = nil) -> RequestBuilder<[Candidate]> {
        var localVariablePath = "/api/admin/candidates/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "is_free": (wrappedValue: isFree?.encodeToJSON(), isExplode: true),
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Candidate]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список кандидатов
     
     - parameter id: (path) A unique integer value identifying this Кандидат.
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - parameter patchedCandidate: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminCandidatesPartialUpdate(id: Int, isFree: String? = nil, search: String? = nil, patchedCandidate: PatchedCandidate? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Candidate]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminCandidatesPartialUpdateWithRequestBuilder(id: id, isFree: isFree, search: search, patchedCandidate: patchedCandidate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список кандидатов
     - PATCH /api/admin/candidates/{id}/
     - Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Кандидат.
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - parameter patchedCandidate: (body)  (optional)
     - returns: RequestBuilder<[Candidate]>
     */
    open class func apiAdminCandidatesPartialUpdateWithRequestBuilder(id: Int, isFree: String? = nil, search: String? = nil, patchedCandidate: PatchedCandidate? = nil) -> RequestBuilder<[Candidate]> {
        var localVariablePath = "/api/admin/candidates/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: patchedCandidate)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "is_free": (wrappedValue: isFree?.encodeToJSON(), isExplode: true),
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Candidate]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список кандидатов
     
     - parameter id: (path) A unique integer value identifying this Кандидат.
     - parameter candidate: (body)
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminCandidatesUpdate(id: Int, candidate: Candidate, isFree: String? = nil, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Candidate]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminCandidatesUpdateWithRequestBuilder(id: id, candidate: candidate, isFree: isFree, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список кандидатов
     - PUT /api/admin/candidates/{id}/
     - Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Кандидат.
     - parameter candidate: (body)
     - parameter isFree: (query) Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
     - parameter search: (query) Поиск кандидатов по имени (регистронезависимый). (optional)
     - returns: RequestBuilder<[Candidate]>
     */
    open class func apiAdminCandidatesUpdateWithRequestBuilder(id: Int, candidate: Candidate, isFree: String? = nil, search: String? = nil) -> RequestBuilder<[Candidate]> {
        var localVariablePath = "/api/admin/candidates/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: candidate)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "is_free": (wrappedValue: isFree?.encodeToJSON(), isExplode: true),
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Candidate]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PUT", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить список офисов
     
     - parameter office: (body)
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminOfficesCreate(office: Office, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Office?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminOfficesCreateWithRequestBuilder(office: office, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить список офисов
     - POST /api/admin/offices/
     - Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter office: (body)
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - returns: RequestBuilder<Office>
     */
    open class func apiAdminOfficesCreateWithRequestBuilder(office: Office, search: String? = nil) -> RequestBuilder<Office> {
        let localVariablePath = "/api/admin/offices/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: office)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Office>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить список офисов
     
     - parameter id: (path) A unique integer value identifying this Офис.
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminOfficesDestroy(id: Int, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminOfficesDestroyWithRequestBuilder(id: id, search: search).execute(apiResponseQueue) { result in
            switch result {
            case .success:
                completion((), nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить список офисов
     - DELETE /api/admin/offices/{id}/
     - Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Офис.
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - returns: RequestBuilder<Void>
     */
    open class func apiAdminOfficesDestroyWithRequestBuilder(id: Int, search: String? = nil) -> RequestBuilder<Void> {
        var localVariablePath = "/api/admin/offices/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Void>.Type = MielClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить список офисов
     
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminOfficesList(search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Office]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminOfficesListWithRequestBuilder(search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить список офисов
     - GET /api/admin/offices/
     - Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - returns: RequestBuilder<[Office]>
     */
    open class func apiAdminOfficesListWithRequestBuilder(search: String? = nil) -> RequestBuilder<[Office]> {
        let localVariablePath = "/api/admin/offices/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Office]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить список офисов
     
     - parameter id: (path) A unique integer value identifying this Офис.
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - parameter patchedOffice: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminOfficesPartialUpdate(id: Int, search: String? = nil, patchedOffice: PatchedOffice? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Office?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminOfficesPartialUpdateWithRequestBuilder(id: id, search: search, patchedOffice: patchedOffice).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить список офисов
     - PATCH /api/admin/offices/{id}/
     - Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Офис.
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - parameter patchedOffice: (body)  (optional)
     - returns: RequestBuilder<Office>
     */
    open class func apiAdminOfficesPartialUpdateWithRequestBuilder(id: Int, search: String? = nil, patchedOffice: PatchedOffice? = nil) -> RequestBuilder<Office> {
        var localVariablePath = "/api/admin/offices/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: patchedOffice)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Office>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить список офисов
     
     - parameter id: (path) A unique integer value identifying this Офис.
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminOfficesRetrieve(id: Int, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Office?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminOfficesRetrieveWithRequestBuilder(id: id, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить список офисов
     - GET /api/admin/offices/{id}/
     - Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Офис.
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - returns: RequestBuilder<Office>
     */
    open class func apiAdminOfficesRetrieveWithRequestBuilder(id: Int, search: String? = nil) -> RequestBuilder<Office> {
        var localVariablePath = "/api/admin/offices/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Office>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить список офисов
     
     - parameter id: (path) A unique integer value identifying this Офис.
     - parameter office: (body)
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminOfficesUpdate(id: Int, office: Office, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Office?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminOfficesUpdateWithRequestBuilder(id: id, office: office, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить список офисов
     - PUT /api/admin/offices/{id}/
     - Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Офис.
     - parameter office: (body)
     - parameter search: (query) Фильтр по названию офиса (регистронезависимый поиск). (optional)
     - returns: RequestBuilder<Office>
     */
    open class func apiAdminOfficesUpdateWithRequestBuilder(id: Int, office: Office, search: String? = nil) -> RequestBuilder<Office> {
        var localVariablePath = "/api/admin/offices/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: office)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Office>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PUT", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Массовое обновление квот офисов
     
     - parameter body: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminQuotasUpdateCreate(body: AnyCodable? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminQuotasUpdateCreateWithRequestBuilder(body: body).execute(apiResponseQueue) { result in
            switch result {
            case .success:
                completion((), nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Массовое обновление квот офисов
     - POST /api/admin/quotas/update/
     - Позволяет администратору изменить квоты нескольких офисов сразу. Если новое значение квоты больше текущего, происходит увеличение, если меньше — уменьшение. Для каждой операции создается транзакция.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter body: (body)  (optional)
     - returns: RequestBuilder<Void>
     */
    open class func apiAdminQuotasUpdateCreateWithRequestBuilder(body: AnyCodable? = nil) -> RequestBuilder<Void> {
        let localVariablePath = "/api/admin/quotas/update/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Void>.Type = MielClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Статистика приглашений
     
     - parameter endDate: (query) Конечная дата в формате YYYY-MM-DDTHH:MM:SSZ. (optional)
     - parameter officeId: (query) id фильтруемого оффиса (optional)
     - parameter startDate: (query) Начальная дата в формате YYYY-MM-DDTHH:MM:SSZ. (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminStatisticInvitationsList(endDate: String? = nil, officeId: String? = nil, startDate: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [InvitationStatistics]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminStatisticInvitationsListWithRequestBuilder(endDate: endDate, officeId: officeId, startDate: startDate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Статистика приглашений
     - GET /api/admin/statistic/invitations/
     - Позволяет получить статистику по приглашениям с фильтрацией по диапазону дат.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter endDate: (query) Конечная дата в формате YYYY-MM-DDTHH:MM:SSZ. (optional)
     - parameter officeId: (query) id фильтруемого оффиса (optional)
     - parameter startDate: (query) Начальная дата в формате YYYY-MM-DDTHH:MM:SSZ. (optional)
     - returns: RequestBuilder<[InvitationStatistics]>
     */
    open class func apiAdminStatisticInvitationsListWithRequestBuilder(endDate: String? = nil, officeId: String? = nil, startDate: String? = nil) -> RequestBuilder<[InvitationStatistics]> {
        let localVariablePath = "/api/admin/statistic/invitations/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "end_date": (wrappedValue: endDate?.encodeToJSON(), isExplode: true),
            "office_id": (wrappedValue: officeId?.encodeToJSON(), isExplode: true),
            "start_date": (wrappedValue: startDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[InvitationStatistics]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение статистики по месяцам для администратора
     
     - parameter year: (query) Год, за который необходимо получить статистику. По умолчанию 10 последних месяцев. (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminStatisticQuotasRetrieve(year: Int? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: AnyCodable?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminStatisticQuotasRetrieveWithRequestBuilder(year: year).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение статистики по месяцам для администратора
     - GET /api/admin/statistic/quotas/
     - Возвращает статистику по транзакциям и приглашениям по месяцам за указанный год. Если год не указан, возвращаются данные за последние 10 месяцев.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter year: (query) Год, за который необходимо получить статистику. По умолчанию 10 последних месяцев. (optional)
     - returns: RequestBuilder<AnyCodable>
     */
    open class func apiAdminStatisticQuotasRetrieveWithRequestBuilder(year: Int? = nil) -> RequestBuilder<AnyCodable> {
        let localVariablePath = "/api/admin/statistic/quotas/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "year": (wrappedValue: year?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AnyCodable>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список супервайзеров
     
     - parameter supervisor: (body)
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminSupervisorsCreate(supervisor: Supervisor, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Supervisor]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminSupervisorsCreateWithRequestBuilder(supervisor: supervisor, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список супервайзеров
     - POST /api/admin/supervisors/
     - Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter supervisor: (body)
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - returns: RequestBuilder<[Supervisor]>
     */
    open class func apiAdminSupervisorsCreateWithRequestBuilder(supervisor: Supervisor, search: String? = nil) -> RequestBuilder<[Supervisor]> {
        let localVariablePath = "/api/admin/supervisors/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: supervisor)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Supervisor]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список супервайзеров
     
     - parameter id: (path) A unique integer value identifying this Руководитель.
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminSupervisorsDestroy(id: Int, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Supervisor]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminSupervisorsDestroyWithRequestBuilder(id: id, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список супервайзеров
     - DELETE /api/admin/supervisors/{id}/
     - Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Руководитель.
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - returns: RequestBuilder<[Supervisor]>
     */
    open class func apiAdminSupervisorsDestroyWithRequestBuilder(id: Int, search: String? = nil) -> RequestBuilder<[Supervisor]> {
        var localVariablePath = "/api/admin/supervisors/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Supervisor]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список супервайзеров
     
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminSupervisorsList(search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Supervisor]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminSupervisorsListWithRequestBuilder(search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список супервайзеров
     - GET /api/admin/supervisors/
     - Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - returns: RequestBuilder<[Supervisor]>
     */
    open class func apiAdminSupervisorsListWithRequestBuilder(search: String? = nil) -> RequestBuilder<[Supervisor]> {
        let localVariablePath = "/api/admin/supervisors/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Supervisor]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список супервайзеров
     
     - parameter id: (path) A unique integer value identifying this Руководитель.
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminSupervisorsList2(id: Int, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Supervisor]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminSupervisorsList2WithRequestBuilder(id: id, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список супервайзеров
     - GET /api/admin/supervisors/{id}/
     - Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Руководитель.
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - returns: RequestBuilder<[Supervisor]>
     */
    open class func apiAdminSupervisorsList2WithRequestBuilder(id: Int, search: String? = nil) -> RequestBuilder<[Supervisor]> {
        var localVariablePath = "/api/admin/supervisors/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Supervisor]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список супервайзеров
     
     - parameter id: (path) A unique integer value identifying this Руководитель.
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - parameter patchedSupervisor: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminSupervisorsPartialUpdate(id: Int, search: String? = nil, patchedSupervisor: PatchedSupervisor? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Supervisor]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminSupervisorsPartialUpdateWithRequestBuilder(id: id, search: search, patchedSupervisor: patchedSupervisor).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список супервайзеров
     - PATCH /api/admin/supervisors/{id}/
     - Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Руководитель.
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - parameter patchedSupervisor: (body)  (optional)
     - returns: RequestBuilder<[Supervisor]>
     */
    open class func apiAdminSupervisorsPartialUpdateWithRequestBuilder(id: Int, search: String? = nil, patchedSupervisor: PatchedSupervisor? = nil) -> RequestBuilder<[Supervisor]> {
        var localVariablePath = "/api/admin/supervisors/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: patchedSupervisor)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Supervisor]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Список супервайзеров
     
     - parameter id: (path) A unique integer value identifying this Руководитель.
     - parameter supervisor: (body)
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiAdminSupervisorsUpdate(id: Int, supervisor: Supervisor, search: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Supervisor]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiAdminSupervisorsUpdateWithRequestBuilder(id: id, supervisor: supervisor, search: search).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Список супервайзеров
     - PUT /api/admin/supervisors/{id}/
     - Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Руководитель.
     - parameter supervisor: (body)
     - parameter search: (query) Поиск по имени, фамилии или отчество пользователя. (optional)
     - returns: RequestBuilder<[Supervisor]>
     */
    open class func apiAdminSupervisorsUpdateWithRequestBuilder(id: Int, supervisor: Supervisor, search: String? = nil) -> RequestBuilder<[Supervisor]> {
        var localVariablePath = "/api/admin/supervisors/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: supervisor)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "search": (wrappedValue: search?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Supervisor]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PUT", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение полной информации о пользователе
     
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiInfoRetrieve(apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: AnyCodable?, _ error: Error?) -> Void)) -> RequestTask {
        return apiInfoRetrieveWithRequestBuilder().execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение полной информации о пользователе
     - GET /api/info/
     - Возвращает информацию о пользователе в зависимости от его роли. Если пользователь администратор, возвращаются данные об администраторе. Если супервайзер, возвращаются данные о супервайзере. Иначе ошибка.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - returns: RequestBuilder<AnyCodable>
     */
    open class func apiInfoRetrieveWithRequestBuilder() -> RequestBuilder<AnyCodable> {
        let localVariablePath = "/api/info/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AnyCodable>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Обновление ссылки чата
     
     - parameter link: (query) Ссылка на чат, должна начинаться с &#39;https&#39;
     - parameter platform: (query) Платформа чата, доступные значения: &#39;telegram&#39;, &#39;whatsapp&#39;
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiLinkCreate(link: String, platform: String, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: AnyCodable?, _ error: Error?) -> Void)) -> RequestTask {
        return apiLinkCreateWithRequestBuilder(link: link, platform: platform).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Обновление ссылки чата
     - POST /api/link/
     - Метод POST позволяет администраторам обновить ссылку чата для платформы 'telegram' или 'whatsapp'. Ссылка должна быть валидной (начинаться с 'https').
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter link: (query) Ссылка на чат, должна начинаться с &#39;https&#39;
     - parameter platform: (query) Платформа чата, доступные значения: &#39;telegram&#39;, &#39;whatsapp&#39;
     - returns: RequestBuilder<AnyCodable>
     */
    open class func apiLinkCreateWithRequestBuilder(link: String, platform: String) -> RequestBuilder<AnyCodable> {
        let localVariablePath = "/api/link/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "link": (wrappedValue: link.encodeToJSON(), isExplode: true),
            "platform": (wrappedValue: platform.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AnyCodable>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение ссылки чата
     
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiLinkRetrieve(apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: AnyCodable?, _ error: Error?) -> Void)) -> RequestTask {
        return apiLinkRetrieveWithRequestBuilder().execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение ссылки чата
     - GET /api/link/
     - Метод GET позволяет получить текущую ссылку чата на чат с администратором
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - returns: RequestBuilder<AnyCodable>
     */
    open class func apiLinkRetrieveWithRequestBuilder() -> RequestBuilder<AnyCodable> {
        let localVariablePath = "/api/link/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AnyCodable>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Авторизация пользователя
     
     - parameter body: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiLoginCreate(body: AnyCodable? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: AnyCodable?, _ error: Error?) -> Void)) -> RequestTask {
        return apiLoginCreateWithRequestBuilder(body: body).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Авторизация пользователя
     - POST /api/login/
     - Позволяет пользователю авторизоваться, предоставив имя пользователя и пароль. Возвращает токен доступа, если учетные данные верны.полученный токен нужно передавать в headers в поле Authorization в формате Token <token>
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter body: (body)  (optional)
     - returns: RequestBuilder<AnyCodable>
     */
    open class func apiLoginCreateWithRequestBuilder(body: AnyCodable? = nil) -> RequestBuilder<AnyCodable> {
        let localVariablePath = "/api/login/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AnyCodable>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Выход из системы
     
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiLogoutCreate(apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: AnyCodable?, _ error: Error?) -> Void)) -> RequestTask {
        return apiLogoutCreateWithRequestBuilder().execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Выход из системы
     - POST /api/logout/
     - Удаляет токен текущего пользователя, завершая его сессию.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - returns: RequestBuilder<AnyCodable>
     */
    open class func apiLogoutCreateWithRequestBuilder() -> RequestBuilder<AnyCodable> {
        let localVariablePath = "/api/logout/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AnyCodable>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение информации о кандидатах
     
     - parameter age: (query) Фильтрация по точному возрасту кандидата. (optional)
     - parameter ageMax: (query) Максимальный возраст для фильтрации кандидатов. (optional)
     - parameter ageMin: (query) Минимальный возраст для фильтрации кандидатов. (optional)
     - parameter byNew: (query) Сортировка по дате создания. Значения: true (по убыванию), false (по возрастанию). (optional)
     - parameter courses: (query) Фильтрация по пройденным курсам. Укажите через запятую. Возможные значения: &#x60;course_rieltor_join&#x60; (курс риэлторов), &#x60;basic_legal_course&#x60; (базовый юридический курс), &#x60;course_mortgage&#x60; (курс ипотечного кредитования), &#x60;course_taxation&#x60; (курс по налогообложению). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorCandidatesList(age: Int? = nil, ageMax: Int? = nil, ageMin: Int? = nil, byNew: String? = nil, courses: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [CandidateInfo]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorCandidatesListWithRequestBuilder(age: age, ageMax: ageMax, ageMin: ageMin, byNew: byNew, courses: courses).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение информации о кандидатах
     - GET /api/supervisor/candidates/
     - Возвращает список доступных кандидатов с фильтрацией по возрасту, курсам и дате создания.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter age: (query) Фильтрация по точному возрасту кандидата. (optional)
     - parameter ageMax: (query) Максимальный возраст для фильтрации кандидатов. (optional)
     - parameter ageMin: (query) Минимальный возраст для фильтрации кандидатов. (optional)
     - parameter byNew: (query) Сортировка по дате создания. Значения: true (по убыванию), false (по возрастанию). (optional)
     - parameter courses: (query) Фильтрация по пройденным курсам. Укажите через запятую. Возможные значения: &#x60;course_rieltor_join&#x60; (курс риэлторов), &#x60;basic_legal_course&#x60; (базовый юридический курс), &#x60;course_mortgage&#x60; (курс ипотечного кредитования), &#x60;course_taxation&#x60; (курс по налогообложению). (optional)
     - returns: RequestBuilder<[CandidateInfo]>
     */
    open class func apiSupervisorCandidatesListWithRequestBuilder(age: Int? = nil, ageMax: Int? = nil, ageMin: Int? = nil, byNew: String? = nil, courses: String? = nil) -> RequestBuilder<[CandidateInfo]> {
        let localVariablePath = "/api/supervisor/candidates/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "age": (wrappedValue: age?.encodeToJSON(), isExplode: true),
            "age_max": (wrappedValue: ageMax?.encodeToJSON(), isExplode: true),
            "age_min": (wrappedValue: ageMin?.encodeToJSON(), isExplode: true),
            "by_new": (wrappedValue: byNew?.encodeToJSON(), isExplode: true),
            "courses": (wrappedValue: courses?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[CandidateInfo]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Добавить в избранное
     
     - parameter favorite: (body)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorFavoritesCreate(favorite: Favorite, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Favorite?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorFavoritesCreateWithRequestBuilder(favorite: favorite).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Добавить в избранное
     - POST /api/supervisor/favorites/
     - Добавляет новый объект в избранное для текущего пользователя.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter favorite: (body)
     - returns: RequestBuilder<Favorite>
     */
    open class func apiSupervisorFavoritesCreateWithRequestBuilder(favorite: Favorite) -> RequestBuilder<Favorite> {
        let localVariablePath = "/api/supervisor/favorites/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: favorite)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Favorite>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Удалить из избранного
     
     - parameter id: (path)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorFavoritesDestroy(id: String, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorFavoritesDestroyWithRequestBuilder(id: id).execute(apiResponseQueue) { result in
            switch result {
            case .success:
                completion((), nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Удалить из избранного
     - DELETE /api/supervisor/favorites/{id}/
     - Удаляет объект из избранного пользователя.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path)
     - returns: RequestBuilder<Void>
     */
    open class func apiSupervisorFavoritesDestroyWithRequestBuilder(id: String) -> RequestBuilder<Void> {
        var localVariablePath = "/api/supervisor/favorites/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Void>.Type = MielClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить список избранного
     
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorFavoritesList(apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Favorite]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorFavoritesListWithRequestBuilder().execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить список избранного
     - GET /api/supervisor/favorites/
     - Возвращает список избранных объектов пользователя.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - returns: RequestBuilder<[Favorite]>
     */
    open class func apiSupervisorFavoritesListWithRequestBuilder() -> RequestBuilder<[Favorite]> {
        let localVariablePath = "/api/supervisor/favorites/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Favorite]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**

     - parameter id: (path)
     - parameter patchedFavorite: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorFavoritesPartialUpdate(id: String, patchedFavorite: PatchedFavorite? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Favorite?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorFavoritesPartialUpdateWithRequestBuilder(id: id, patchedFavorite: patchedFavorite).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     - PATCH /api/supervisor/favorites/{id}/
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path)
     - parameter patchedFavorite: (body)  (optional)
     - returns: RequestBuilder<Favorite>
     */
    open class func apiSupervisorFavoritesPartialUpdateWithRequestBuilder(id: String, patchedFavorite: PatchedFavorite? = nil) -> RequestBuilder<Favorite> {
        var localVariablePath = "/api/supervisor/favorites/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: patchedFavorite)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Favorite>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить избранный объект
     
     - parameter id: (path)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorFavoritesRetrieve(id: String, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Favorite?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorFavoritesRetrieveWithRequestBuilder(id: id).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить избранный объект
     - GET /api/supervisor/favorites/{id}/
     - Возвращает подробную информацию об объекте в избранном.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path)
     - returns: RequestBuilder<Favorite>
     */
    open class func apiSupervisorFavoritesRetrieveWithRequestBuilder(id: String) -> RequestBuilder<Favorite> {
        var localVariablePath = "/api/supervisor/favorites/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Favorite>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Обновить избранный объект
     
     - parameter id: (path)
     - parameter favorite: (body)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorFavoritesUpdate(id: String, favorite: Favorite, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Favorite?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorFavoritesUpdateWithRequestBuilder(id: id, favorite: favorite).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Обновить избранный объект
     - PUT /api/supervisor/favorites/{id}/
     - Обновляет данные избранного объекта.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path)
     - parameter favorite: (body)
     - returns: RequestBuilder<Favorite>
     */
    open class func apiSupervisorFavoritesUpdateWithRequestBuilder(id: String, favorite: Favorite) -> RequestBuilder<Favorite> {
        var localVariablePath = "/api/supervisor/favorites/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: favorite)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Favorite>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PUT", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Создать новое приглашение
     
     - parameter invitation: (body)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorInvitationsCreate(invitation: Invitation, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: Invitation?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorInvitationsCreateWithRequestBuilder(invitation: invitation).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Создать новое приглашение
     - POST /api/supervisor/invitations/
     - Создает новое приглашение для кандидата, проверяя наличие квоты у офиса.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter invitation: (body)
     - returns: RequestBuilder<Invitation>
     */
    open class func apiSupervisorInvitationsCreateWithRequestBuilder(invitation: Invitation) -> RequestBuilder<Invitation> {
        let localVariablePath = "/api/supervisor/invitations/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: invitation)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Invitation>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение списка приглашённых кандидатов
     
     - parameter endDate: (query) Фильтр по дате: конец диапазона (формат &#39;YYYY-MM-DD&#39;). (optional)
     - parameter startDate: (query) Фильтр по дате: начало диапазона (формат &#39;YYYY-MM-DD&#39;). (optional)
     - parameter status: (query) Фильтр по статусу приглашений (invited, accepted, rejected, self_rejected). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorInvitationsRetrieve(endDate: String? = nil, startDate: String? = nil, status: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Invitation]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorInvitationsRetrieveWithRequestBuilder(endDate: endDate, startDate: startDate, status: status).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение списка приглашённых кандидатов
     - GET /api/supervisor/invitations/
     - Возвращает список приглашённых рук-лем кандидатов, с поддержкой фильтрации и отправкой новых приглашений
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter endDate: (query) Фильтр по дате: конец диапазона (формат &#39;YYYY-MM-DD&#39;). (optional)
     - parameter startDate: (query) Фильтр по дате: начало диапазона (формат &#39;YYYY-MM-DD&#39;). (optional)
     - parameter status: (query) Фильтр по статусу приглашений (invited, accepted, rejected, self_rejected). (optional)
     - returns: RequestBuilder<[Invitation]>
     */
    open class func apiSupervisorInvitationsRetrieveWithRequestBuilder(endDate: String? = nil, startDate: String? = nil, status: String? = nil) -> RequestBuilder<[Invitation]> {
        let localVariablePath = "/api/supervisor/invitations/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "end_date": (wrappedValue: endDate?.encodeToJSON(), isExplode: true),
            "start_date": (wrappedValue: startDate?.encodeToJSON(), isExplode: true),
            "status": (wrappedValue: status?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Invitation]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Статистика по месяцам
     
     - parameter year: (query) Год для фильтрации статистики (например, 2024). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiSupervisorStatisticQuotasList(year: Int? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [MonthlyStatistic]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiSupervisorStatisticQuotasListWithRequestBuilder(year: year).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Статистика по месяцам
     - GET /api/supervisor/statistic/quotas/
     - Возвращает статистику по месяцам за указанный год или последние 10 месяцев по умолчанию. Для фильтрации можно передать параметр `year` (например, ?year=2024).
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter year: (query) Год для фильтрации статистики (например, 2024). (optional)
     - returns: RequestBuilder<[MonthlyStatistic]>
     */
    open class func apiSupervisorStatisticQuotasListWithRequestBuilder(year: Int? = nil) -> RequestBuilder<[MonthlyStatistic]> {
        let localVariablePath = "/api/supervisor/statistic/quotas/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "year": (wrappedValue: year?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[MonthlyStatistic]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получить статистику TODO
     
     - parameter endDate: (query) Фильтр задач по конечной дате создания (формат &#39;YYYY-MM-DD&#39;). (optional)
     - parameter startDate: (query) Фильтр задач по начальной дате создания (формат &#39;YYYY-MM-DD&#39;). (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiTodoStatsRetrieve(endDate: Date? = nil, startDate: Date? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [String: AnyCodable]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiTodoStatsRetrieveWithRequestBuilder(endDate: endDate, startDate: startDate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получить статистику TODO
     - GET /api/todo-stats/
     - Возвращает статистику задач пользователя: общее количество созданных, завершённых, удалённых задач, а также дни недели с максимальной активностью.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter endDate: (query) Фильтр задач по конечной дате создания (формат &#39;YYYY-MM-DD&#39;). (optional)
     - parameter startDate: (query) Фильтр задач по начальной дате создания (формат &#39;YYYY-MM-DD&#39;). (optional)
     - returns: RequestBuilder<[String: AnyCodable]>
     */
    open class func apiTodoStatsRetrieveWithRequestBuilder(endDate: Date? = nil, startDate: Date? = nil) -> RequestBuilder<[String: AnyCodable]> {
        let localVariablePath = "/api/todo-stats/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "end_date": (wrappedValue: endDate?.encodeToJSON(), isExplode: true),
            "start_date": (wrappedValue: startDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[String: AnyCodable]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение списка задач
     
     - parameter todo: (body)
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiTodosCreate(todo: Todo, dueDate: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Todo]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiTodosCreateWithRequestBuilder(todo: todo, dueDate: dueDate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение списка задач
     - POST /api/todos/
     - Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter todo: (body)
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - returns: RequestBuilder<[Todo]>
     */
    open class func apiTodosCreateWithRequestBuilder(todo: Todo, dueDate: String? = nil) -> RequestBuilder<[Todo]> {
        let localVariablePath = "/api/todos/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: todo)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "due_date": (wrappedValue: dueDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Todo]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение списка задач
     
     - parameter id: (path) A unique integer value identifying this Задача.
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiTodosDestroy(id: Int, dueDate: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Todo]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiTodosDestroyWithRequestBuilder(id: id, dueDate: dueDate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение списка задач
     - DELETE /api/todos/{id}/
     - Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Задача.
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - returns: RequestBuilder<[Todo]>
     */
    open class func apiTodosDestroyWithRequestBuilder(id: Int, dueDate: String? = nil) -> RequestBuilder<[Todo]> {
        var localVariablePath = "/api/todos/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "due_date": (wrappedValue: dueDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Todo]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение списка задач
     
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiTodosList(dueDate: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Todo]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiTodosListWithRequestBuilder(dueDate: dueDate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение списка задач
     - GET /api/todos/
     - Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - returns: RequestBuilder<[Todo]>
     */
    open class func apiTodosListWithRequestBuilder(dueDate: String? = nil) -> RequestBuilder<[Todo]> {
        let localVariablePath = "/api/todos/"
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "due_date": (wrappedValue: dueDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Todo]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение списка задач
     
     - parameter id: (path) A unique integer value identifying this Задача.
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - parameter patchedTodo: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiTodosPartialUpdate(id: Int, dueDate: String? = nil, patchedTodo: PatchedTodo? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Todo]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiTodosPartialUpdateWithRequestBuilder(id: id, dueDate: dueDate, patchedTodo: patchedTodo).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение списка задач
     - PATCH /api/todos/{id}/
     - Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Задача.
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - parameter patchedTodo: (body)  (optional)
     - returns: RequestBuilder<[Todo]>
     */
    open class func apiTodosPartialUpdateWithRequestBuilder(id: Int, dueDate: String? = nil, patchedTodo: PatchedTodo? = nil) -> RequestBuilder<[Todo]> {
        var localVariablePath = "/api/todos/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: patchedTodo)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "due_date": (wrappedValue: dueDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Todo]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение списка задач
     
     - parameter id: (path) A unique integer value identifying this Задача.
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiTodosRetrieve(id: Int, dueDate: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Todo]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiTodosRetrieveWithRequestBuilder(id: id, dueDate: dueDate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение списка задач
     - GET /api/todos/{id}/
     - Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Задача.
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - returns: RequestBuilder<[Todo]>
     */
    open class func apiTodosRetrieveWithRequestBuilder(id: Int, dueDate: String? = nil) -> RequestBuilder<[Todo]> {
        var localVariablePath = "/api/todos/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "due_date": (wrappedValue: dueDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Todo]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Получение списка задач
     
     - parameter id: (path) A unique integer value identifying this Задача.
     - parameter todo: (body)
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func apiTodosUpdate(id: Int, todo: Todo, dueDate: String? = nil, apiResponseQueue: DispatchQueue = MielClientAPI.apiResponseQueue, completion: @escaping ((_ data: [Todo]?, _ error: Error?) -> Void)) -> RequestTask {
        return apiTodosUpdateWithRequestBuilder(id: id, todo: todo, dueDate: dueDate).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Получение списка задач
     - PUT /api/todos/{id}/
     - Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.
     - API Key:
       - type: apiKey Authorization (HEADER)
       - name: tokenAuth
     - parameter id: (path) A unique integer value identifying this Задача.
     - parameter todo: (body)
     - parameter dueDate: (query) Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) (optional)
     - returns: RequestBuilder<[Todo]>
     */
    open class func apiTodosUpdateWithRequestBuilder(id: Int, todo: Todo, dueDate: String? = nil) -> RequestBuilder<[Todo]> {
        var localVariablePath = "/api/todos/{id}/"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = MielClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: todo)

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "due_date": (wrappedValue: dueDate?.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<[Todo]>.Type = MielClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PUT", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }
}
